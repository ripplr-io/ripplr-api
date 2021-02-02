class ReportsController < ApplicationController
  include JsonApi::Crudable

  authorize_resource class: :report

  def create
    report = ReportForm.new(report_params)
    report.post = Post.find_by(id: params[:post_id])
    return render_errors(report.errors) unless report.valid?

    Support::NewReportMailer.perform_async(current_user.id, report.post.id, report.reason, report.body)
    head :no_content
  end

  private

  def report_params
    params.permit(:reason, :body)
  end
end
