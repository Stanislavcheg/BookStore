module Authentication
  extend ActiveSupport::Concern

  module ClassMethods
    def self.new_with_session(params, session)
      super.tap do |user|
        if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
          user.email = data['email'] if user.email.blank?
        end
      end
    end

    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.name = auth.info.name
        user.image = auth.info.image
        user.confirmed_at = Time.zone.now
        user.save!
      end
    end
  end
end
