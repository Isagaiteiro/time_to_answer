namespace :dev do

  DEFAULT_PASSWORD = 123456
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando o banco de dados...") { %x(rails db:drop) }
      show_spinner("Criando o banco de dados...") { %x(rails db:create)}
      show_spinner("Migrando as tabelas...") {%x(rails db:migrate)}
      show_spinner("Cadastrando o administrador padrão...") {%x(rails dev:add_default_admin)}
      show_spinner("Cadastrando o usuário padrão...") {%x(rails dev:add_default_user)}
      
    else
      puts "Você não está no ambiente de desenvolvimento!"
    end
  end

  desc "Adiciona o administrador padrão"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adiciona o usuário padrão"
  task add_default_user: :environment do
    User.create!(
      email: 'user@user.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  private

  def show_spinner(msg_start, msg_end = "Concluído com sucesso!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}...")
    spinner.auto_spin
    yield #Executa um bloco de código entre do e end quando tem várias linhas, ou entre chaves quando tem só uma linha a ser executada
    spinner.success(msg_end)
  end

end
