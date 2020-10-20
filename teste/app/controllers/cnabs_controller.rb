class CnabsController < ApplicationController
  before_action :set_cnab, only: [:show, :edit, :update, :destroy]

  # GET /cnabs
  # GET /cnabs.json
  def index
    @cnabs = Cnab.group_by_stores
  end

  # GET /cnabs/1
  # GET /cnabs/1.json
  def show
  end

  # GET /cnabs/new
  def new
    @cnab = Cnab.new
  end

  # GET /cnabs/1/edit
  def edit
  end

  # POST /cnabs/1
  def store
    @cnabs = Cnab.list_by_store(params[:id])
  end  

  def document(file)
    File.open(file, "r")
  end

  def parseLineCnab(line)
    {
      'tipo'     => line[0],
      'data'     => line[1..8],
      'valor'    => (line[9..18].to_f / 100).truncate(2),
      'cpf'      => line[19..29],
      'cartao'   => line[30..41],
      'hora'     => line[42..47],
      'dono'     => line[48..61],
      'loja'     => line[62..79]
    }
  end

  # POST /cnabs
  # POST /cnabs.json
  def create
    file = self.document(params[:file])
    count = 0
    file.each_line { |line|
      cnab_line = self.parseLineCnab(line)
      @cnab = Cnab.new(cnab_line)
      @cnab.save
      count += 1
    }
    file.close
    respond_to do |format|
      if @cnab.save
        format.html { redirect_to cnabs_url, notice: "#{count} importações concluídas." }
        format.json { render :show, status: :created, location: @cnab }
      else
        format.html { render :new }
        format.json { render json: @cnab.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cnabs/1
  # PATCH/PUT /cnabs/1.json
  def update
    respond_to do |format|
      if @cnab.update(cnab_params)
        format.html { redirect_to @cnab, notice: 'Cnab atualizado.' }
        format.json { render :show, status: :ok, location: @cnab }
      else
        format.html { render :edit }
        format.json { render json: @cnab.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cnabs/1
  # DELETE /cnabs/1.json
  def destroy
    @cnab.destroy
    respond_to do |format|
      format.html { redirect_to cnabs_url, notice: 'Cnab excluído.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cnab
      @cnab = Cnab.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cnab_params
      params.require(:cnab).permit(:tipo, :data, :valor, :cpf, :cartao, :hora, :dono, :loja)
    end
end
