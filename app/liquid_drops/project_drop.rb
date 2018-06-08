class ProjectDrop < DpLiquidDrop


  def logo
    if @source.logo.present?
      image_tag(@project.logo)
    end
  end

  def export_name
    nil_or_string_value @source.project_name_export
  end

  def export_name_length
    nil_or_integer_value @source.project_name_export.length
  end

  def notes
    if @source.project_notes.try(:strip).present? || (template_objects["firm"].show_project_notes && template_objects["firm"].project_notes.to_s.strip.present?)
      (@source.project_notes.try(:strip).present? || template_objects["firm"].project_notes).gsub(/(?:\n\r?|\r\n?)/, '<br>').html_safe    
    end
  end

  def city_state
    if @source.city.present_as_string? || @source.state.present_as_string?
      [@source.city, @source.state].compact.join(", ")
    end
  end

  def project_number
    if @source.project_number.present_as_string?
      @source.project_number
    else
      "----"
    end
  end

  
  def office_logo
    if @source.try(:office).try(:logo).present?
      image_tag(@source.try(:office).try(:logo).try(@firm.show_horizontal_logo ? :horizontal : :sq128 ).try(:url))
    end
  end


  def show_address
    @source.hide_address == false
  end

  def office_full_address
    @office_full_address ||= (
      if @source.office.try(:full_address).try(:strip).present?
        @source.office.full_address
      end
    )
  end


  def statuses
    @statuses ||= (
      if @source.project_statuses.present?
        @source.project_statuses.collect{|x| ProjectStatusDrop.new(x)}
      end
    )
  end

  def status_dates
    if self.statuses.present?
      self.statuses.collect(&:event_date).join(" | ")
    end
  end


end