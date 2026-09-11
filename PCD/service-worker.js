// ============================================================
// SERVICE WORKER — PalЫCH Service PWA v1.0
// ============================================================

const CACHE_NAME = 'palych-service-v1';
const RUNTIME_CACHE = 'palych-service-runtime-v1';

const PRECACHE_URLS = [
    './index.html',
    './manifest.json',
    './icons/icon-192.png',
    './icons/icon-512.png'
];

// УСТАНОВКА
self.addEventListener('install', event => {
    console.log('📦 Service SW: установка...');
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
    console.log('✅ Service SW: активация');
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

// FETCH — стратегия: сеть в приоритете (для актуальных данных), кэш как fallback
self.addEventListener('fetch', event => {
    const { request } = event;
    const url = new URL(request.url);

    // Supabase — всегда только сеть, ничего не кэшируем
    if (url.hostname.includes('supabase.co')) {
        event.respondWith(fetch(request).catch(() => new Response('{"error":"offline"}', {
            headers: { 'Content-Type': 'application/json' }
        })));
        return;
    }

    // Остальное — сначала сеть, потом кэш
    event.respondWith(
        fetch(request).then(response => {
            // Кэшируем успешные GET-запросы
            if (response && response.status === 200 && request.method === 'GET') {
                const responseClone = response.clone();
                caches.open(RUNTIME_CACHE).then(cache => {
                    cache.put(request, responseClone);
                });
            }
            return response;
        }).catch(() => {
            // Если сеть недоступна — берём из кэша
            return caches.match(request).then(cachedResponse => {
                if (cachedResponse) return cachedResponse;
                
                // Если это навигация — показываем index.html
                if (request.mode === 'navigate') {
                    return caches.match('./index.html');
                }
            });
        })
    );
});

// PUSH-УВЕДОМЛЕНИЯ (для мастера — уведомления о новых заявках)
self.addEventListener('push', event => {
    console.log('🔔 Push получен (сервис)');
    
    let data = {
        title: 'PalЫCH Сервис',
        body: 'Новое уведомление',
        icon: './icons/icon-192.png',
        badge: './icons/icon-192.png',
        url: './index.html'
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
            vibrate: [300, 100, 300],
            tag: 'palych-service',
            renotify: true,
            data: { url: data.url }
        })
    );
});

// КЛИК ПО УВЕДОМЛЕНИЮ
self.addEventListener('notificationclick', event => {
    event.notification.close();
    const url = event.notification.data?.url || './index.html';
    
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

console.log('🚀 Service Worker (PalЫCH Сервис) загружен');