class ReportsController < ApplicationController
  include Crudable

  authorize_resource class: :report

  def create
    report = ReportForm.new(report_params)
    report.post = Post.find_by(id: params[:post_id])
    return render_errors(report) unless report.valid?

    SupportMailer.new_report(current_user, report.post, report_params).deliver_later
    head :no_content
  end

  private

  def report_params
    params.permit(:reason, :body)
  end
end
