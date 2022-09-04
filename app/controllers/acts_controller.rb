class ActsController < ApplicationController
  def new
  end

  def create
    if params[:signature].blank? || params[:act].blank?
      err_msg =
        if params[:signature].blank? && params[:act].blank?
          'Оба параметра отсутствуют'
        elsif params[:signature].blank?
          'Подпись отсутствует'
        else
          'Акт отсутствует'
        end
      return redirect_to action: :new, flash: { error: err_msg }
    end

    tmp_filename = './tmp.pdf'
    output_filename = './result.pdf'
    signature_path = params[:signature].path

    Prawn::Document.generate(tmp_filename) do
      # signature = './signature/signature.png'
      image signature_path, :at => [345, 325], scale: 0.25
    end

    signature = CombinePDF.load(tmp_filename).pages[0]
    act_path = params[:act].path
    pdf = CombinePDF.load act_path
    pdf.pages.each { |page| page << signature } # notice the << operator is on a page and not a PDF object.
    pdf.save output_filename
    send_file output_filename
  end
end
