module CartsHelper
  def checkout_url
    user_signed_in? ? checkout_index_path : new_user_session_path
  end
end
