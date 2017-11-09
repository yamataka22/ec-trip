# 失敗したジョブを消さない
Delayed::Worker.destroy_failed_jobs = false
# リトライしない
Delayed::Worker.max_attempts = 0
# ログを分ける
Delayed::Worker.logger =Logger.new(File.join(Rails.root,'log','delayed_job.log'))

# 定期的なUPDATEログを非表示にする
# https://github.com/collectiveidea/delayed_job/issues/477
unless Rails.env.production?
  module Delayed
    module Backend
      module ActiveRecord
        class Job
          class << self
            alias_method :reserve_original, :reserve
            def reserve(worker, max_run_time = Worker.max_run_time)
              previous_level = ::ActiveRecord::Base.logger.level
              ::ActiveRecord::Base.logger.level = Logger::WARN if previous_level < Logger::WARN
              value = reserve_original(worker, max_run_time)
              ::ActiveRecord::Base.logger.level = previous_level
              value
            end
          end
        end
      end
    end
  end
end