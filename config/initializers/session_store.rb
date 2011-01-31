require 'action_dispatch/middleware/session/dalli_store'

Gamelog::Application.config.session_store :dalli_store, {
  :memcache_server => ['localhost'],
  :namespace       => 'game_log:sessions',
  :key             => '_gamelog_session',
  :expire_after    => 30.days
}
