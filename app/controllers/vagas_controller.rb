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

  private

  def vaga_params
    params.require(:vaga).permit(:descricao)
  end
end
