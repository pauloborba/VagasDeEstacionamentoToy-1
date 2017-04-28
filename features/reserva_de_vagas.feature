Feature: reserva de vagas de estacionamento
  As um usuário do sistema de estacionamento
  I quero ser capaz de reservar uma vaga de estacionamento
  so that eu possa me dirigir diretamente para a vaga reservada

  Scenario: reserva com estacionamento cheio
    Given todas as vagas estão ocupadas
    When Eu tento reservar uma vaga
    Then O sistema não faz nenhuma reserva

  Scenario: reserva com estacionamento com vagas
    Given algumas vagas não estão ocupadas
    When Eu tento reservar uma vaga
    Then O sistema reserva uma das vagas desocupadas

  Scenario: seleção de vaga livre
   Given eu criei as vagas "e1" e "e2"
   And eu estou na página de visualização das vagas
   And eu vejo a vaga "e2" vazia
   When eu seleciono a vaga "e2"
   Then a vaga "e2" é marcada como ocupada
