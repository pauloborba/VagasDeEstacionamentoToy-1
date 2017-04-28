@vagas = []
Given(/^todas as vagas estão ocupadas$/) do
  param_vaga1 = {vaga: {descricao: 'vaga1', ocupada: true}}
  param_vaga2 = {vaga: {descricao: 'vaga2', ocupada: true}}
  param_vaga3 = {vaga: {descricao: 'vaga3', ocupada: true}}

  #executa a chamada ao controlador da rota
  #rota /vagas por POST chama a action create do controlador Vaga
  #rota /vagas por GET chama a action index do controlador Vaga
  #Para saber todas as rotas execute o rake routes no terminal ou RubyMine
  #param_vagaN são os parametros que serão passado para o controller
  #os parametros são do tipo Hash

  post '/vagas', param_vaga1
  post '/vagas', param_vaga2
  post '/vagas', param_vaga3

  assert Vaga.where(ocupada: false).empty?
end

When(/^Eu tento reservar uma vaga$/) do
  @vagas = Vaga.all
  p @vagas
  #Chama a rota reservar_url que chama o controlador Vagas e action reservar
  post reservar_url
end

Then(/^O sistema não faz nenhuma reserva$/) do
  vagas = Vaga.all
  assert compare_vagas(vagas, @vagas)
end

Given(/^algumas vagas não estão ocupadas$/) do
  param_vaga1 = {vaga: {descricao: 'vaga1', ocupada: true}}
  param_vaga2 = {vaga: {descricao: 'vaga2', ocupada: false}}

  post '/vagas', param_vaga1
  post '/vagas', param_vaga2

  assert !Vaga.where(ocupada: false).empty?
end

Then(/^O sistema reserva uma das vagas desocupadas$/) do
  vagas = Vaga.all
  assert !compare_vagas(vagas, @vagas)
end

Given(/^eu criei as vagas "([^"]*)" e "([^"]*)"$/) do |arg1, arg2|
  #Capybara é a biblioteca responsavel por modificar e acessar elementos da view
  #https://github.com/teamcapybara/capybara
  visit '/vagas/new'
  fill_in('vaga_descricao', with: arg1)
  click_button('Criar')
  visit '/vagas/new'
  fill_in('vaga_descricao', with: arg2)
  click_button('Criar')
end

Given(/^eu estou na página de visualização das vagas$/) do
  visit '/overview'
end

Given(/^eu vejo a vaga "([^"]*)" vazia$/) do |arg1|
  #Procurando um elemento not html que seja td e que tenha o texto igual arg1
  element = find("td", text: arg1)
  #Verificando se o elemento tem uma class no html igual a green
  assert element[:class] == 'green'
end

When(/^eu seleciono a vaga "([^"]*)"$/) do |arg1|
  click_on(arg1)
end

Then(/^a vaga "([^"]*)" é marcada como ocupada$/) do |arg1|
  #Procurando um elemento not html que seja td e que tenha o texto igual arg1
  element = find("td", text: arg1)
  #Verificando se o elemento tem uma class no html igual a green
  assert element[:class] == 'red'
end

def compare_vaga(vaga1, vaga2)
  vaga1.attributes == vaga2.attributes
end

def compare_vagas(vagas1, vagas2)
  return false if vagas1.count != vagas2.count

  equal = true
  vagas1.each_with_index do |vaga,i|
    equal = compare_vaga(vaga, vagas2[i])
  end
  equal
end
