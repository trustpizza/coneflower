module ModeratorAuthentication
    extend ActiveSupport::Concern

    included do
        before_action :authenticate_user!
        before_action :require_moderator_or_higher
        layout "moderator"
    end

    private

    def require_admin_or_higher
        unless current_user.admin? || current_user.owner?
        redirect_to root_path, alert: 'You are not authorized to access this page.'
        end
    end

    def require_moderator_or_higher
        unless current_user.moderator? || current_user.admin? || current_user.owner?
        redirect_to root_path, alert: 'You are not authorized to access this page.'
        end
    end
end