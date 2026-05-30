Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self, :https
    policy.font_src    :self, :https, :data, "fonts.googleapis.com", "fonts.gstatic.com"
    policy.img_src     :self, :https, :data, :blob
    policy.object_src  :none
    # tailwindcss cdn + importmap
    policy.script_src  :self, :https, :unsafe_inline, "cdn.tailwindcss.com"
    policy.style_src   :self, :https, :unsafe_inline, "fonts.googleapis.com"
    policy.connect_src :self, :https, "ws://localhost:3000", "wss://localhost:3000"
  end
end
