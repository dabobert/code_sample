class ExportPresenter
  
  def initialize(project, export, office, user, project_product_ids, options={})
    if project.is_a?(Project)
      @project = project
    else
      @project = Project.find(project)
    end

    if export.is_a?(ExportTemplate)
      @export = export
    else
      @export = ExportTemplate.find(export)
    end

    if office.is_a?(Office)
      @office = office
    else
      @office = Office.find(office)
    end

    if user.respond_to?(:email)
      @user = user
    else
      @user = User.find(user)
    end

    if @export.treat_nested_as_normal?
      @project_products = @project.project_products.where(:id => project_product_ids)
    else
      @project_products = @project.project_products.where(:id => project_product_ids).roots
    end
    @options = options
    @firm    = @user.firm
  end


  def filename
    @filename ||= @export.filename(@project.filename_prefix)
  end

  def render_options
    

    fn_render_options = {
      :layout => "pdf.html.erb",
      :pdf => self.filename,
      :template => "firm/templates/show.html.erb",
      :encoding => "UTF-8", 
      :orientation => @export.orientation,
      :page_size => 'Letter', 
      :header => header_settings,
      :margin => margin_settings,
      :footer => footer_settings,
      :javascript_delay => 100
    }

    if @options[:debug].blank?
      # make it an attachment
      fn_render_options.merge! :disposition => 'attachment'
    else
      # add Timestamp to the end
      filename.gsub ".pdf", ".#{Time.now.to_i}.pdf"
    end

    fn_render_options
  end

  def render_export_as_html
    ApplicationController.render render_options.except(:pdf).merge :assigns => assignments, :show_as_html => true
  end

  def render_export
    ApplicationController.render render_options.merge :assigns => assignments
  end

  def header_settings
    if @export.header.present?
      {      
        :content => generate_header_html,
        :spacing => 9
      }                    
    else
      {}
    end
  end


  def assignments
    {
      :export => @export,
      :firm => @firm,
      :project => @project,
      :office => @office,
      :project_products => @project_products
    }
  end

  def margin_settings
    { :top => @export.margin_top, :bottom => @export.margin_bottom }.compact
  end

  def footer_settings
    if @export.footer.present?
      {      
        :content => generate_footer_html,
        :spacing => 8# ~63 pixels
      }                    
    else
      {}
    end
  end

  def generate_header_html
    ApplicationController.render :layout => "pdf.html.erb", :template => "firm/templates/_pdf_header.html", :assigns => assignments
  end

  def generate_footer_html
    ApplicationController.render :layout => "pdf.html.erb", :template => "firm/templates/_pdf_footer.html", :assigns => assignments
  end

end
