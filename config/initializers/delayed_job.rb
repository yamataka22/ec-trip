# 失敗したジョブを消さない
Delayed::Worker.destroy_failed_jobs = false
# リトライしない
Delayed::Worker.max_attempts = 0
# ログを分ける
Delayed::Worker.logger =Logger.new(File.join(Rails.root,'log','delayed_job.log'))