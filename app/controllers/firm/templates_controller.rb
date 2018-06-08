class Firm::TemplatesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :redirect_non_premium_users!

  def new
    @export = ExportTemplate.new
    @export.assign_json_values
    render :action => :action
  end

  def create
    begin
      @export = ExportTemplate.new export_template_params
      @export.creator_id = current_user.id
      @export.firm_id    = current_user.firm.try(:id)
      @export.save!
      flash[:success] = "Template created"
      redirect_after_save && return
    rescue ActiveRecord::RecordInvalid => error
      flash[:error] = error.message
      render :action => :action
    end 
  end


  def index
    # 2 is the id of designerpages itself. Any template owned by designerpages is treated as a global template 
    @templates = ExportTemplate.where(:firm_id => [2,@firm.id])
  end

  def show
    # if we have debug redirect to the preview action
    if params[:debug].present?
      redirect_to preview_firm_template_path(params[:id])
    else
      @project = Project.find params[:project_id]
      @office  = current_user.try(:office) || @firm.offices.first
      @export  = ExportTemplate.find(params[:id])
      @project_products = @project.project_products.where(:id => params[:project_product_id])

      if @export.treat_nested_as_normal? == false
        @project_products = @project_products.roots
      end

      @project_product_ids  = @project_products.pluck(:id)
      num_project_products  = @project_product_ids.count


      if num_project_products > 10
        Resque.enqueue(ExportGenerator, @project.id, @export.id, @office.id, current_user.id, @project_product_ids)
        flash[:notice] = "This is a large project! It will take us a second to get the pdf ready for you. Once the pdf is ready, we will email you a link to the ZIP file to your account's email address. Thanks!"
      else
        options = params.dup
        @export_presenter = ExportPresenter.new(@project, params[:id], @office, current_user, @project_product_ids, options)
        render @export_presenter.render_options
      end
    end
  end

  def edit
    @export = ExportTemplate.find(params[:id])
    render :action => :action
  end

  def update
    begin
      @export = ExportTemplate.find(params[:id])
      @export.update_attributes! export_template_params
      flash[:success] = "Template updated"
      redirect_after_save && return
    rescue ActiveRecord::RecordInvalid => error
      flash[:error] = error.message
      render :action => :action
    end 
  end

  def view_source
    @export = ExportTemplate.find(params[:id])
  end

  def preview
    @project = Project.find 2989861
    @office  = @project.office
    @export  = ExportTemplate.find(params[:id])
    @debug   = 1

    if @export.treat_nested_as_normal?
      @project_products = @project.project_products#.where(:id => [1501561,1557441,2476812,1553101,1553411,2365481])
    else
      @project_products = @project.project_products.roots#.where(:id => [1501561,1557441,2476812,1553101,1553411,2365481]).order("id desc")
    end
    
    respond_to do |format|
      format.html do
        @format = :html
        render :action => :show, :layout => "pdf"
      end

      format.pdf do
        options = params.merge(:debug => @debug)
        @export_presenter = ExportPresenter.new(@project, params[:id], @office, current_user, @project.project_products.pluck(:id), options)
        render @export_presenter.render_options
      end
    end
  end

  def duplicate
    begin
      @export = ExportTemplate.find(params[:id])
      @dupe   = @export.dup
      @dupe.name += " (copy ##{Time.now.to_i})"
      @dupe.firm_id = @firm.id
      @dupe.creator_id = current_user.id
      @dupe.save!
      redirect_to firm_templates_path
    rescue ActiveRecord::RecordInvalid => error
      flash[:error] = error.message
      render :action => :action
    end 
  end

  ############################################################################
  private
  ############################################################################

  def redirect_after_save
    if params[:commit].to_s.downcase.include? "close"
      redirect_to firm_templates_path
    else
      redirect_to edit_firm_template_path(@export)
    end
  end

end
