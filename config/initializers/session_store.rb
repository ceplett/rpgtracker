require 'action_dispatch/middleware/session/dalli_store'

RpgTracker::Application.config.session_store :dalli_store, {
  :memcache_server => ['localhost'],
  :namespace       => 'rpgtracker:sessions',
  :key             => '_rpgtracker_session',
  :expire_after    => 30.days
}
