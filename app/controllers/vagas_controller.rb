class VagasController < ApplicationController
  def index
    @vagas = Vaga.all
  end

  def show
    @vaga = Vaga.find(params[:id])
  end

  def new
    @vaga = Vaga.new
  end

  def edit
    @vaga = Vaga.find(params[:id])
  end

  def destroy
    @vaga = Vaga.find(params[:id])
    @vaga.destroy

    redirect_to vagas_url, notice: 'Vaga foi deletada com sucesso'
  end

  def create
    @vaga = Vaga.new(vaga_params)

    if @vaga.ocupada
      @vaga.reservas.build(entrada: Time.now)
    end

    if @vaga.save
      redirect_to @vaga, notice: 'Vaga foi salva com sucesso'
    else
      render :new
    end
  end

  def update
    @vaga = Vaga.find(params[:id])

    if @vaga.update(vaga_params)
      redirect_to @vaga, notice: 'Vaga foi atualizada com sucesso'
    else
      render :edit
    end
  end

  def overview
    @vagas = Vaga.all
  end

  def reservar
    vagas = Vaga.where(ocupada: false)
    notice = ""
    if(vagas.empty?)
      notice = 'Vaga indisponivel'
    else
      vaga = vagas.first
      vaga.reservar_ou_desocupar
      notice = 'Vaga reservada'
    end

    redirect_to overview_url, notice: notice
  end

  private

  def vaga_params
    params.require(:vaga).permit(:descricao, :ocupada)
  end
end
