# TODO: Move to support/reports
class ReportsController < ApplicationController
  include JsonApi::Crudable

  load_resource :post
  authorize_resource class: :support

  def create
    report = ReportForm.new(report_params)
    return render_errors(report.errors) unless report.valid?

    Support::NewReportMailer.perform_async(current_user.id, report.post.id, report.reason, report.body)
    head :no_content
  end

  private

  def report_params
    params.permit(:reason, :body).merge(post: @post)
  end
end
