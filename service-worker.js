// ============================================================
// SERVICE WORKER — PalЫCH Client PWA v1.0
// ============================================================

const CACHE_NAME = 'palych-client-v1';
const RUNTIME_CACHE = 'palych-runtime-v1';

const PRECACHE_URLS = [
    './index.html',
    './manifest.json',
    './icons/icon-192.png',
    './icons/icon-512.png'
];

// УСТАНОВКА
self.addEventListener('install', event => {
    console.log('📦 SW: установка...');
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then(cache => cache.addAll(PRECACHE_URLS).catch(err => {
                console.warn('⚠️ Не все файлы закэшированы:', err);
            }))
            .then(() => self.skipWaiting())
    );
});

// АКТИВАЦИЯ
self.addEventListener('activate', event => {
    console.log('✅ SW: активация');
    event.waitUntil(
        caches.keys().then(cacheNames => {
            return Promise.all(
                cacheNames
                    .filter(name => name !== CACHE_NAME && name !== RUNTIME_CACHE)
                    .map(name => caches.delete(name))
            );
        }).then(() => self.clients.claim())
    );
});

// FETCH
self.addEventListener('fetch', event => {
    const { request } = event;
    const url = new URL(request.url);

    // Supabase — всегда свежие данные
    if (url.hostname.includes('supabase.co')) {
        event.respondWith(fetch(request).catch(() => caches.match(request)));
        return;
    }

    event.respondWith(
        caches.match(request).then(cachedResponse => {
            if (cachedResponse) {
                fetch(request).then(response => {
                    if (response && response.status === 200) {
                        caches.open(RUNTIME_CACHE).then(cache => {
                            cache.put(request, response.clone());
                        });
                    }
                }).catch(() => {});
                return cachedResponse;
            }

            return fetch(request).then(response => {
                if (response && response.status === 200 && request.method === 'GET') {
                    const responseClone = response.clone();
                    caches.open(RUNTIME_CACHE).then(cache => {
                        cache.put(request, responseClone);
                    });
                }
                return response;
            }).catch(() => {
                if (request.mode === 'navigate') {
                    return caches.match('./index.html');
                }
            });
        })
    );
});

// PUSH-УВЕДОМЛЕНИЯ
self.addEventListener('push', event => {
    console.log('🔔 Push получен');
    let data = {
        title: 'PalЫCH',
        body: 'Новое уведомление',
        icon: './icons/icon-192.png',
        badge: './icons/icon-192.png'
    };
    if (event.data) {
        try {
            data = { ...data, ...event.data.json() };
        } catch (e) {
            data.body = event.data.text();
        }
    }
    event.waitUntil(
        self.registration.showNotification(data.title, {
            body: data.body,
            icon: data.icon,
            badge: data.badge,
            vibrate: [200, 100, 200],
            tag: 'palych-notification',
            requireInteraction: true,
            data: data.url || './index.html'
        })
    );
});

// КЛИК ПО УВЕДОМЛЕНИЮ
self.addEventListener('notificationclick', event => {
    event.notification.close();
    const url = event.notification.data || './index.html';
    event.waitUntil(
        clients.matchAll({ type: 'window', includeUncontrolled: true })
            .then(clientList => {
                for (const client of clientList) {
                    if (client.url.includes('index.html') && 'focus' in client) {
                        return client.focus();
                    }
                }
                if (clients.openWindow) {
                    return clients.openWindow(url);
                }
            })
    );
});

console.log('🚀 Service Worker загружен');