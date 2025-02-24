ENV['xero_api_client_id'] = '7615D492D8AA4E13977D1256F82403AF' #replace this with your own client_id
ENV['xero_api_client_secret'] = '09PIoSBMNpYkKYXIIQeSW3CAG6cdZXgq7oMb49LJRMVmOGfI' #replace this with your own client_secret

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :xero_oauth2,
    ENV['xero_api_client_id'],
    ENV['xero_api_client_secret'],
    scope: 'openid profile email offline_access',
    client_options: {
      site: "https://xero.api.ledgerscope.com",
      token_url: "https://xero.api.ledgerscope.com/1004/connect/token",
      authorize_url: "https://xero.api.ledgerscope.com/1004/identity/connect/authorize",
      connections_url: "https://xero.api.ledgerscope.com/1004/connections"
    },
  )
end

# Since Omniauth 2.0.0, we need the following token verfication process
class TokenVerifier
  include ActiveSupport::Configurable
  include ActionController::RequestForgeryProtection

  def call(env)
    @request = ActionDispatch::Request.new(env.dup)
    raise OmniAuth::AuthenticityError unless verified_request?
  end

  private
  attr_reader :request
  delegate :params, :session, to: :request
end

OmniAuth.config.request_validation_phase = TokenVerifier.new

# by default the callback url / redirect_uri on developer.xero.com should be seet to /auth/xero_oauth2/callback
# to override it, added redirect_uri: 'https:/your.app/callback/url' to provider() function 