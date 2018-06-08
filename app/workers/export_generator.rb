class ExportGenerator

  @queue = :project_export_queue

  def self.perform(project_id, export_id, office_id, user_id, project_product_ids)
    project = Project.find(project_id)
    user    = User.find(user_id)
    export_presenter = ExportPresenter.new(project_id, export_id, office_id, user_id, project_product_ids)

    temp_file = Tempfile.new([export_presenter.filename, '.pdf'])
    temp_file.binmode
    temp_file.write(WickedPdf.new.pdf_from_string(
      export_presenter.render_export_as_html,
      export_presenter.render_options
    ))
    temp_file.close

    archive_file = Archive.create! :archivable => project, :filename => temp_file


# if !recipient.nil? && archive_file.save
        ProjectsMailer.send_export_email(user, project, archive_file.filename_url)
      # else
      #   raise "The archive file couldn't save in S3 - project: #{@project.name}"
      # end


  end
end