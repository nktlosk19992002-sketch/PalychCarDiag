<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PalЫCH Car Diagnost v4.6</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Roboto, system-ui, sans-serif; }
        body { background: #f4f7fb; display: flex; justify-content: center; align-items: center; min-height: 100vh; padding: 20px; }
        .app-container { max-width: 1400px; width: 100%; background: white; border-radius: 32px; box-shadow: 0 20px 40px rgba(0,0,0,0.15); overflow: hidden; }
        .app-header { background: #0b2b3c; padding: 18px 32px; color: white; display: flex; align-items: center; gap: 14px; border-bottom: 4px solid #f6b83d; flex-wrap: wrap; }
        .app-header h1 { font-weight: 600; font-size: 1.7rem; display: flex; align-items: center; gap: 10px; cursor: pointer; }
        .app-header h1 i { color: #f6b83d; }
        .app-header .sub { margin-left: auto; font-size: 0.9rem; background: #1f4a5e; padding: 6px 18px; border-radius: 40px; color: #d4e9f5; }
        .app-header .nav-buttons { display: flex; gap: 8px; margin-left: 20px; flex-wrap: wrap; align-items: center; }
        .app-header .nav-buttons button { background: transparent; border: 1px solid #3a6b7e; color: #d4e9f5; padding: 6px 16px; border-radius: 30px; cursor: pointer; font-size: 0.85rem; transition: 0.2s; }
        .app-header .nav-buttons button:hover { background: #1f4a5e; border-color: #f6b83d; }
        .app-header .nav-buttons button.active { background: #f6b83d; color: #0b2b3c; border-color: #f6b83d; }
        .app-header .file-actions { display: flex; gap: 6px; margin-left: 10px; flex-wrap: wrap; align-items: center; }
        .app-header .file-actions button { background: #1f4a5e; border: 1px solid #3a6b7e; color: #d4e9f5; padding: 4px 12px; border-radius: 20px; cursor: pointer; font-size: 0.75rem; transition: 0.2s; }
        .app-header .file-actions button:hover { background: #2a5a6e; border-color: #f6b83d; }
        .app-header .file-actions .save-btn { background: #1f7b4a; border-color: #1f7b4a; }
        .app-header .file-actions .save-btn:hover { background: #2a965a; }
        .app-header .file-actions .cloud-send { background: #1f7b4a; border-color: #1f7b4a; }
        .app-header .file-actions .cloud-send:hover { background: #2a965a; }
        .app-header .file-actions .cloud-pull { background: #2d6b84; border-color: #2d6b84; }
        .app-header .file-actions .cloud-pull:hover { background: #3a7b94; }
        .app-header .file-status { font-size: 0.75rem; color: #8ab4c9; margin-left: 10px; }
        
        .tabs { display: flex; background: #eef2f7; border-bottom: 1px solid #d0d9e4; padding: 0 20px; gap: 4px; flex-wrap: wrap; overflow-x: auto; }
        .tab-btn { background: transparent; border: none; padding: 16px 24px; font-weight: 600; font-size: 0.95rem; color: #2d4b5e; cursor: pointer; border-bottom: 4px solid transparent; transition: 0.2s; display: flex; align-items: center; gap: 8px; white-space: nowrap; }
        .tab-btn i { font-size: 1.1rem; color: #3f6b81; }
        .tab-btn.active { background: white; color: #0b2b3c; border-bottom: 4px solid #f6b83d; border-radius: 12px 12px 0 0; }
        .tab-btn.active i { color: #f6b83d; }
        .tab-btn:hover { background: #dce4ed; }
        .tab-content { padding: 24px 28px 28px; display: none; animation: fade 0.25s ease; }
        .tab-content.active { display: block; }
        @keyframes fade { 0% { opacity: 0.5; transform: translateY(6px); } 100% { opacity: 1; transform: translateY(0); } }

        .main-menu { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 20px; justify-content: center; align-items: stretch; min-height: 280px; }
        .menu-card { background: white; border-radius: 24px; padding: 24px 20px; text-align: center; cursor: pointer; transition: 0.3s; border: 2px solid #e4ecf4; display: flex; flex-direction: column; align-items: center; justify-content: center; }
        .menu-card:hover { transform: translateY(-6px); box-shadow: 0 20px 40px rgba(0,0,0,0.1); border-color: #f6b83d; }
        .menu-card i { font-size: 2.8rem; margin-bottom: 10px; display: block; }
        .menu-card .icon-diag i { color: #f6b83d; }
        .menu-card .icon-repair i { color: #1f7b4a; }
        .menu-card .icon-journal i { color: #2d6b84; }
        .menu-card .icon-settings i { color: #6c5b7b; }
        .menu-card .icon-bookings i { color: #d4a017; }
        .menu-card .icon-etalons i { color: #8b5cf6; }
        .menu-card .icon-clients i { color: #2d6b84; }
        .menu-card .icon-prices i { color: #e67e22; }
        .menu-card h2 { font-size: 1.2rem; color: #0b2b3c; margin-bottom: 4px; }
        .menu-card p { color: #3a657e; font-size: 0.8rem; }

        .card-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 14px; margin-top: 12px; }
        .system-card { background: white; border-radius: 14px; padding: 14px 14px; box-shadow: 0 4px 12px rgba(0,0,0,0.04); border: 1px solid #e6edf4; cursor: pointer; transition: 0.2s; }
        .system-card:hover { transform: translateY(-3px); box-shadow: 0 10px 20px rgba(0,40,60,0.08); border-color: #cbdae6; }
        .system-card .title { font-weight: 700; font-size: 0.95rem; color: #0b2b3c; display: flex; justify-content: space-between; }
        .system-card .badge { background: #eef3f8; padding: 2px 10px; border-radius: 30px; font-size: 0.65rem; font-weight: 600; color: #1b4b62; }
        .system-card .desc { font-size: 0.75rem; color: #2b556b; opacity: 0.8; margin-top: 4px; }

        .form-group { margin-bottom: 14px; }
        .form-group label { display: block; font-weight: 600; margin-bottom: 4px; color: #1f4055; font-size: 0.85rem; }
        .form-group input, .form-group textarea, .form-group select { width: 100%; padding: 10px 14px; border: 1px solid #d4dee9; border-radius: 12px; font-size: 0.9rem; transition: 0.15s; background: #fafcff; }
        .form-group input:focus, .form-group textarea:focus, .form-group select:focus { border-color: #f6b83d; outline: none; background: white; box-shadow: 0 0 0 3px rgba(246,184,61,0.15); }
        .row-3col { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 14px; }
        .row-2col { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }
        .row-4col { display: grid; grid-template-columns: 1fr 1fr 1fr 0.7fr; gap: 10px; }

        .btn-primary { background: #0b2b3c; color: white; border: none; padding: 10px 22px; border-radius: 50px; font-weight: 700; font-size: 0.9rem; display: inline-flex; align-items: center; gap: 8px; cursor: pointer; transition: 0.2s; }
        .btn-primary i { color: #f6b83d; }
        .btn-primary:hover { background: #1c4055; transform: scale(1.01); }
        .btn-success { background: #1f7b4a; color: white; border: none; padding: 10px 22px; border-radius: 50px; font-weight: 700; font-size: 0.9rem; display: inline-flex; align-items: center; gap: 8px; cursor: pointer; transition: 0.2s; }
        .btn-success i { color: #f6b83d; }
        .btn-success:hover { background: #2a965a; transform: scale(1.01); }
        .btn-danger { background: #b33c3c; color: white; border: none; padding: 4px 12px; border-radius: 30px; font-size: 0.7rem; cursor: pointer; }
        .btn-danger:hover { background: #a12b2b; }
        .btn-warning { background: #d4a017; color: white; border: none; padding: 4px 12px; border-radius: 30px; font-size: 0.7rem; cursor: pointer; }
        .btn-warning:hover { background: #b8890f; }
        .btn-sm { padding: 4px 14px; border-radius: 30px; border: none; font-size: 0.75rem; cursor: pointer; }
        .btn-outline { background: transparent; border: 1px solid #0b2b3c; color: #0b2b3c; padding: 4px 14px; border-radius: 30px; font-size: 0.7rem; cursor: pointer; }
        .btn-outline:hover { background: #0b2b3c; color: white; }
        .btn-copy { background: #6c5b7b; color: white; border: none; padding: 3px 10px; border-radius: 20px; font-size: 0.65rem; cursor: pointer; }
        .btn-copy:hover { background: #5a4a69; }
        .btn-link { background: transparent; border: none; color: #1f7b4a; cursor: pointer; font-size: 0.75rem; text-decoration: underline; }
        .btn-link:hover { color: #0a6030; }
        .btn-insert { background: #2d6b84; color: white; border: none; padding: 3px 10px; border-radius: 20px; font-size: 0.6rem; cursor: pointer; }
        .btn-insert:hover { background: #1f4a5e; }

        .modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.4); backdrop-filter: blur(4px); justify-content: center; align-items: center; z-index: 999; }
        .modal-overlay.active { display: flex; }
        .modal-box { background: white; max-width: 1100px; width: 95%; max-height: 90vh; border-radius: 24px; padding: 24px 28px; box-shadow: 0 30px 60px rgba(0,0,0,0.4); overflow-y: auto; position: relative; }
        .modal-close { position: sticky; top: 0; float: right; background: #eef2f7; border: none; width: 36px; height: 36px; border-radius: 40px; font-size: 1.2rem; cursor: pointer; color: #1f4055; z-index: 10; }
        .modal-title { font-size: 1.4rem; font-weight: 700; color: #0b2b3c; margin-bottom: 12px; border-bottom: 3px solid #f6b83d; padding-bottom: 6px; }

        .diagnostic-table { width: 100%; border-collapse: collapse; margin: 10px 0; font-size: 0.82rem; }
        .diagnostic-table th { text-align: left; background: #e4ecf4; padding: 8px 6px; font-size: 0.75rem; color: #1a4055; position: sticky; top: 0; z-index: 5; }
        .diagnostic-table td { padding: 6px 5px; border-bottom: 1px solid #e9eff6; vertical-align: middle; }
        .diagnostic-table tr:last-child td { border-bottom: none; }
        .diagnostic-table input[type="text"], .diagnostic-table input[type="number"], .diagnostic-table textarea { width: 100%; padding: 4px 6px; border: 1px solid #d0dce8; border-radius: 6px; background: white; font-size: 0.8rem; }
        .diagnostic-table input:focus, .diagnostic-table textarea:focus { border-color: #f6b83d; outline: none; box-shadow: 0 0 0 3px rgba(246,184,61,0.15); }
        .diagnostic-table textarea { resize: vertical; min-height: 26px; }

        .status-badge { display: inline-block; padding: 2px 10px; border-radius: 40px; font-weight: 600; font-size: 0.65rem; }
        .status-ok { background: #d3f0d8; color: #0a6030; }
        .status-fail { background: #fadad8; color: #a12b2b; }
        .status-unknown { background: #e8ecf0; color: #4a5e6b; }

        .flex-between { display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 8px; }
        .small-note { color: #3a657e; font-size: 0.8rem; }
        .status-select { padding: 3px 8px; border-radius: 30px; border: 1px solid #d0dce8; background: white; font-weight: 600; font-size: 0.7rem; cursor: pointer; }

        .journal-item { background: white; border: 1px solid #e4ecf4; border-radius: 12px; padding: 12px 16px; margin-bottom: 8px; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 8px; transition: 0.2s; }
        .journal-item:hover { border-color: #f6b83d; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        .journal-item .info { display: flex; gap: 16px; flex-wrap: wrap; align-items: center; }
        .journal-item .info .type { font-weight: 700; color: #0b2b3c; }
        .journal-item .info .type.diag { color: #f6b83d; }
        .journal-item .info .type.repair { color: #1f7b4a; }
        .journal-item .info .date { color: #3a657e; font-size: 0.8rem; }
        .journal-item .info .car { font-weight: 600; color: #0b2b3c; }
        .journal-item .info .plate { background: #eef3f8; padding: 2px 10px; border-radius: 12px; font-size: 0.75rem; font-weight: 700; color: #0b2b3c; }
        .journal-item .actions { display: flex; gap: 6px; }

        .file-status-bar { background: #eef3f8; padding: 6px 16px; border-radius: 8px; margin-bottom: 10px; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; font-size: 0.8rem; color: #1f4055; }
        .file-status-bar .file-name { font-weight: 600; color: #0b2b3c; }

        .settings-group { background: #f8fafc; border-radius: 12px; padding: 16px; margin-bottom: 16px; border: 1px solid #e4ecf4; }
        .settings-group h4 { color: #0b2b3c; margin-bottom: 10px; }
        .settings-item { display: flex; gap: 8px; align-items: center; padding: 6px 0; border-bottom: 1px solid #eef2f7; flex-wrap: wrap; }
        .settings-item .param-name { font-weight: 600; min-width: 150px; color: #1f4055; }
        .settings-item input[type="text"] { flex: 1; min-width: 120px; padding: 4px 8px; border: 1px solid #d0dce8; border-radius: 6px; font-size: 0.85rem; }
        .settings-param-list { display: flex; flex-wrap: wrap; gap: 6px; margin-top: 4px; }
        .settings-param-list .param-tag { background: white; border: 1px solid #d0dce8; border-radius: 20px; padding: 2px 10px; font-size: 0.75rem; display: flex; align-items: center; gap: 6px; }
        .settings-param-list .param-tag .remove { color: #b33c3c; cursor: pointer; font-weight: 700; }

        .bookings-form { background: #f8fafc; padding: 16px; border-radius: 12px; margin-bottom: 16px; border: 1px solid #e4ecf4; }
        .bookings-form .btn-success { width: 100%; justify-content: center; }
        .bookings-table { width: 100%; border-collapse: collapse; font-size: 0.85rem; }
        .bookings-table th { background: #e4ecf4; padding: 10px 8px; text-align: left; font-size: 0.75rem; color: #1a4055; position: sticky; top: 0; z-index: 5; }
        .bookings-table td { padding: 8px 6px; border-bottom: 1px solid #e9eff6; vertical-align: middle; }
        .bookings-table tr:hover td { background: #f8fafc; }
        .bookings-table .status-select { width: auto; padding: 2px 8px; font-size: 0.7rem; }
        .bookings-table input[type="text"], .bookings-table input[type="date"], .bookings-table input[type="time"], .bookings-table select { width: 100%; padding: 4px 6px; border: 1px solid #d0dce8; border-radius: 6px; font-size: 0.8rem; background: white; }
        .bookings-table input:focus, .bookings-table select:focus { border-color: #f6b83d; outline: none; box-shadow: 0 0 0 3px rgba(246,184,61,0.15); }
        .bookings-table .inactive-row { opacity: 0.6; background: #f5f5f5; }
        .bookings-table .inactive-row td input, .bookings-table .inactive-row td select { background: #f0f0f0; cursor: not-allowed; }
        .bookings-table .inactive-row .status-select { background: #f0f0f0; }

        .plate-badge { background: #f6b83d; color: #0b2b3c; padding: 2px 12px; border-radius: 12px; font-weight: 700; font-size: 0.8rem; display: inline-block; }

        .search-box { display: flex; gap: 10px; margin-bottom: 12px; flex-wrap: wrap; }
        .search-box input { padding: 8px 14px; border: 1px solid #d0dce8; border-radius: 10px; font-size: 0.9rem; flex: 1; min-width: 200px; background: white; }
        .search-box input:focus { border-color: #f6b83d; outline: none; box-shadow: 0 0 0 3px rgba(246,184,61,0.15); }
        .search-box select { padding: 8px 14px; border: 1px solid #d0dce8; border-radius: 10px; font-size: 0.9rem; background: white; }

        .etalon-hint { display: inline-block; background: #e8f0fe; color: #1a4055; padding: 1px 8px; border-radius: 12px; font-size: 0.6rem; margin-left: 6px; cursor: help; border: 1px dashed #6c8db0; }
        .etalon-hint:hover { background: #f6b83d; color: #0b2b3c; border-color: #f6b83d; }

        .journal-filters { display: flex; gap: 10px; margin-bottom: 12px; flex-wrap: wrap; }
        .journal-filters select, .journal-filters input { padding: 6px 12px; border: 1px solid #d0dce8; border-radius: 10px; font-size: 0.85rem; background: white; }
        .journal-filters select:focus, .journal-filters input:focus { border-color: #f6b83d; outline: none; box-shadow: 0 0 0 3px rgba(246,184,61,0.15); }

        .param-with-etalon { display: flex; align-items: center; gap: 4px; }
        .param-with-etalon .param-name { font-weight: 600; color: #0b2b3c; }

        .etalon-table { width: 100%; border-collapse: collapse; font-size: 0.85rem; }
        .etalon-table th { background: #e4ecf4; padding: 10px 8px; text-align: left; font-size: 0.75rem; color: #1a4055; }
        .etalon-table td { padding: 6px 8px; border-bottom: 1px solid #e9eff6; vertical-align: middle; }
        .etalon-table input[type="text"] { width: 100%; padding: 4px 6px; border: 1px solid #d0dce8; border-radius: 6px; font-size: 0.8rem; }
        .etalon-table input:focus { border-color: #f6b83d; outline: none; box-shadow: 0 0 0 3px rgba(246,184,61,0.15); }

        .status-icons { display: flex; gap: 6px; align-items: center; }
        .status-icon { width: 34px; height: 34px; border-radius: 50%; border: 2px solid #d0dce8; display: flex; align-items: center; justify-content: center; cursor: pointer; transition: 0.2s; font-size: 0.7rem; background: white; }
        .status-icon:hover { transform: scale(1.05); }
        .status-icon.active-ok { border-color: #0a6030; background: #d3f0d8; color: #0a6030; }
        .status-icon.active-fail { border-color: #a12b2b; background: #fadad8; color: #a12b2b; }
        .status-icon.active-unknown { border-color: #4a5e6b; background: #e8ecf0; color: #4a5e6b; }
        .status-icon .fa-check { color: #0a6030; }
        .status-icon .fa-times { color: #a12b2b; }
        .status-icon .fa-question { color: #4a5e6b; }

        .clients-table { width: 100%; border-collapse: collapse; font-size: 0.85rem; }
        .clients-table th { background: #e4ecf4; padding: 10px 8px; text-align: left; font-size: 0.75rem; color: #1a4055; }
        .clients-table td { padding: 8px 6px; border-bottom: 1px solid #e9eff6; vertical-align: middle; }
        .clients-table tr:hover td { background: #f8fafc; }

        .client-badge { display: inline-block; background: #d3f0d8; color: #0a6030; padding: 2px 10px; border-radius: 12px; font-size: 0.7rem; font-weight: 600; }
        .new-client-badge { display: inline-block; background: #f6b83d; color: #0b2b3c; padding: 2px 10px; border-radius: 12px; font-size: 0.65rem; font-weight: 600; }
        .discount-badge { display: inline-block; background: #f6b83d; color: #0b2b3c; padding: 2px 10px; border-radius: 12px; font-size: 0.7rem; font-weight: 600; }

        .price-section { margin-top: 16px; border: 1px solid #e4ecf4; border-radius: 10px; overflow: hidden; }
        .price-section .section-title { background: #0b2b3c; color: white; padding: 10px 16px; font-weight: 700; font-size: 1.05rem; cursor: pointer; display: flex; justify-content: space-between; align-items: center; }
        .price-section .section-title:hover { background: #1c4055; }
        .price-section .section-title i { color: #f6b83d; }
        .price-row { display: grid; grid-template-columns: 2.5fr 1fr 1fr 0.5fr; padding: 6px 14px; border-bottom: 1px solid #eef2f7; font-size: 0.85rem; align-items: center; }
        .price-row.header { background: #eef3f8; font-weight: 700; font-size: 0.78rem; color: #1f4055; border-bottom: 2px solid #d0dce8; }
        .price-row .service-name { color: #0b2b3c; }
        .price-row .price-dom { color: #1f7b4a; font-weight: 600; }
        .price-row .price-import { color: #d4a017; font-weight: 600; }
        .price-row:hover { background: #f8fafc; }
        .price-search { margin-bottom: 12px; }
        .price-search input { width: 100%; padding: 10px 14px; border: 1px solid #d4dee9; border-radius: 12px; font-size: 0.95rem; }

        .works-table .work-note { font-size: 0.75rem; color: #3a657e; font-style: italic; }
        .price-select-btn { background: #eef3f8; border: 1px solid #d0dce8; border-radius: 20px; padding: 2px 10px; font-size: 0.7rem; cursor: pointer; }
        .price-select-btn:hover { background: #f6b83d; border-color: #f6b83d; }

        .booking-detail-modal .modal-box { max-width: 600px; }
        .booking-detail-modal .detail-row { display: flex; padding: 6px 0; border-bottom: 1px solid #eef2f7; }
        .booking-detail-modal .detail-row .label { font-weight: 600; min-width: 130px; color: #1f4055; }
        .booking-detail-modal .detail-row .value { color: #0b2b3c; }

        .sync-status { font-size: 0.7rem; padding: 2px 10px; border-radius: 20px; }
        .sync-ok { background: #d3f0d8; color: #0a6030; }
        .sync-fail { background: #fadad8; color: #a12b2b; }
        .sync-wait { background: #f6b83d; color: #0b2b3c; }

        .requests-box { background: #f8fafc; border-radius: 16px; padding: 16px 20px; margin-bottom: 20px; border: 2px solid #f6b83d; }
        .requests-box .request-item { background: white; border-radius: 10px; padding: 10px 14px; margin-bottom: 6px; border-left: 4px solid #2d6b84; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 6px; }
        .requests-box .request-item.client-item { border-left-color: #f6b83d; }
        .requests-box .request-item .name { font-weight: 700; color: #0b2b3c; }
        .requests-box .request-item .plate { font-size: 0.8rem; color: #3a657e; margin-left: 8px; }
        .requests-box .request-item .car { font-size: 0.8rem; color: #3a657e; margin-left: 8px; }
        .requests-box .request-item .badge-new { font-size: 0.65rem; padding: 2px 8px; border-radius: 10px; margin-left: 6px; }
        .requests-box .request-item .badge-client { background: #f6b83d; color: #0b2b3c; }
        .requests-box .request-item .badge-booking { background: #2d6b84; color: white; }

        @media print {
            body * { visibility: hidden; }
            #printArea, #printArea * { visibility: visible; }
            #printArea { position: absolute; left: 0; top: 0; width: 100%; padding: 20px; background: white; }
            #printAreaRepair, #printAreaRepair * { visibility: visible; }
            #printAreaRepair { position: absolute; left: 0; top: 0; width: 100%; padding: 20px; background: white; }
            .no-print { display: none !important; }
            .app-header, .tabs, .file-actions, .nav-buttons, .flex-between .btn-success, .flex-between .btn-primary { display: none !important; }
        }

        @media (max-width: 700px) {
            .row-3col { grid-template-columns: 1fr; }
            .row-2col { grid-template-columns: 1fr; }
            .row-4col { grid-template-columns: 1fr 1fr; }
            .row-4col .btn-success { grid-column: 1/-1; }
            .tab-btn { padding: 10px 14px; font-size: 0.75rem; }
            .main-menu { grid-template-columns: 1fr 1fr; }
            .menu-card { padding: 16px; }
            .menu-card i { font-size: 2rem; }
            .journal-item { flex-direction: column; align-items: stretch; }
            .app-header .nav-buttons { margin-left: 0; width: 100%; justify-content: center; }
            .app-header .file-actions { margin-left: 0; width: 100%; justify-content: center; }
            .bookings-table { font-size: 0.7rem; }
            .bookings-table th, .bookings-table td { padding: 4px; }
            .clients-table { font-size: 0.7rem; }
            .clients-table th, .clients-table td { padding: 4px; }
            .status-icons { gap: 3px; }
            .status-icon { width: 28px; height: 28px; font-size: 0.6rem; }
            .price-row { grid-template-columns: 1.5fr 1fr 1fr 0.5fr; font-size: 0.75rem; padding: 4px 10px; }
            .requests-box .request-item { flex-direction: column; align-items: stretch; }
        }
        .hidden { display: none !important; }
        .mt-2 { margin-top: 10px; }
        .mb-2 { margin-bottom: 10px; }
        .text-center { text-align: center; }
        .fw-bold { font-weight: 700; }
        .text-success { color: #0a6030; }
        .text-muted { color: #3a657e; }
        
        .notification-main {
            position: fixed;
            bottom: 20px;
            right: 20px;
            padding: 12px 20px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            z-index: 1000;
            font-weight: 600;
            font-size: 0.9rem;
            animation: slideIn 0.3s ease;
            color: white;
        }
        .notification-main.success { background: #1f7b4a; }
        .notification-main.error { background: #b33c3c; }
        .notification-main.info { background: #0b2b3c; }
        @keyframes slideIn {
            from { transform: translateX(100px); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
    </style>
</head>
<body>
<div class="app-container">
    <div class="app-header">
        <h1 onclick="goHome()"><i class="fas fa-car"></i> PalЫCH</h1>
        <span class="sub"><i class="fas fa-wrench"></i> v4.6</span>
        <div class="nav-buttons">
            <button class="active" onclick="goHome()"><i class="fas fa-home"></i> Главная</button>
            <button onclick="switchMode('diag')"><i class="fas fa-stethoscope"></i> Диагностика</button>
            <button onclick="switchMode('repair')"><i class="fas fa-tools"></i> Ремонт</button>
            <button onclick="switchMode('bookings')"><i class="fas fa-calendar-check"></i> Записи</button>
            <button onclick="switchMode('clients')"><i class="fas fa-users"></i> Клиенты</button>
            <button onclick="switchMode('prices')"><i class="fas fa-ruble-sign"></i> Прайс</button>
            <button onclick="switchMode('journal')"><i class="fas fa-book"></i> Журнал</button>
            <button onclick="switchMode('etalons')"><i class="fas fa-database"></i> Эталоны</button>
            <button onclick="switchMode('settings')"><i class="fas fa-cog"></i> Настройки</button>
        </div>
        <div class="file-actions">
            <button class="save-btn" onclick="saveAllToFile()"><i class="fas fa-save"></i> Сохранить</button>
            <button onclick="document.getElementById('fileInput').click()"><i class="fas fa-folder-open"></i> Открыть</button>
            <input type="file" id="fileInput" accept=".json" style="display:none" onchange="loadFromFile(event)">
            <button class="cloud-send" onclick="sendToCloud()" title="Отправить данные на сервер (JSON)">
                <i class="fas fa-cloud-upload-alt"></i> Отправить
            </button>
            <button class="cloud-pull" onclick="syncFromCloud()" title="Загрузить данные с сервера (JSON)">
                <i class="fas fa-cloud-download-alt"></i> Синхр.
            </button>
        </div>
        <span class="file-status" id="fileStatus">📁 Нет открытого файла</span>
    </div>

    <!-- ===== ГЛАВНАЯ ===== -->
    <div id="page-home" class="tab-content active">
        <div class="file-status-bar">
            <span><i class="fas fa-database"></i> <span class="file-name" id="currentFileName">Нет открытого файла</span></span>
            <span>Записей в журнале: <strong id="journalCount">0</strong></span>
            <span id="cloudStatus"><span class="sync-status sync-ok">☁️ Облако готово</span></span>
        </div>
        
        <!-- ===== ОНЛАЙН ЗАЯВКИ ===== -->
        <div class="requests-box">
            <div class="flex-between" style="margin-bottom: 8px;">
                <h3 style="color:#0b2b3c; font-size:1rem;">
                    <i class="fas fa-bell" style="color:#f6b83d;"></i> Онлайн заявки
                    <span id="newRequestsCount" style="background:#b33c3c;color:white;padding:2px 10px;border-radius:20px;font-size:0.7rem;margin-left:8px;">0</span>
                </h3>
                <button class="btn-primary" onclick="loadNewRequests()" style="padding:6px 16px;font-size:0.8rem;">
                    <i class="fas fa-sync"></i> Обновить
                </button>
            </div>
            <div id="newRequestsContainer" style="max-height:300px; overflow-y:auto;">
                <div style="color:#3a657e; font-size:0.85rem; text-align:center; padding:20px;">
                    <i class="fas fa-inbox" style="font-size:1.5rem; display:block; margin-bottom:6px;"></i>
                    Нет новых заявок
                </div>
            </div>
        </div>
        
        <div class="main-menu">
            <div class="menu-card icon-diag" onclick="switchMode('diag')">
                <i class="fas fa-stethoscope"></i>
                <h2>Диагностика</h2>
                <p>Проверка систем автомобиля</p>
            </div>
            <div class="menu-card icon-repair" onclick="switchMode('repair')">
                <i class="fas fa-tools"></i>
                <h2>Ремонт</h2>
                <p>Учёт запчастей и работ</p>
            </div>
            <div class="menu-card icon-bookings" onclick="switchMode('bookings')">
                <i class="fas fa-calendar-check"></i>
                <h2>Записи</h2>
                <p>Учёт клиентов</p>
            </div>
            <div class="menu-card icon-clients" onclick="switchMode('clients')">
                <i class="fas fa-users"></i>
                <h2>Клиенты</h2>
                <p>База клиентов</p>
            </div>
            <div class="menu-card icon-prices" onclick="switchMode('prices')">
                <i class="fas fa-ruble-sign"></i>
                <h2>Прайс-лист</h2>
                <p>Цены на услуги</p>
            </div>
            <div class="menu-card icon-journal" onclick="switchMode('journal')">
                <i class="fas fa-book"></i>
                <h2>Журнал</h2>
                <p>Сохранённые записи</p>
            </div>
            <div class="menu-card icon-etalons" onclick="switchMode('etalons')">
                <i class="fas fa-database"></i>
                <h2>Эталоны</h2>
                <p>Нормальные значения</p>
            </div>
            <div class="menu-card icon-settings" onclick="switchMode('settings')">
                <i class="fas fa-cog"></i>
                <h2>Настройки</h2>
                <p>Управление системами</p>
            </div>
        </div>
    </div>

    <!-- ===== ДИАГНОСТИКА ===== -->
    <div id="page-diag" class="tab-content">
        <div class="tabs" style="background:transparent; border-bottom:1px solid #d0d9e4; padding:0;">
            <button class="tab-btn active" data-tab="diag1"><i class="fas fa-edit"></i> Регистрация</button>
            <button class="tab-btn" data-tab="diag2"><i class="fas fa-list-ul"></i> Выбор систем</button>
            <button class="tab-btn" data-tab="diag3"><i class="fas fa-clipboard-list"></i> Диагностика</button>
            <button class="tab-btn" data-tab="diag4"><i class="fas fa-file-alt"></i> Лист</button>
        </div>
        <div id="diag1" class="tab-content active" style="padding:14px 0 0;">
            <div class="flex-between" style="margin-bottom:10px;">
                <div class="row-3col" style="flex:1; gap:14px;">
                    <div class="form-group"><label>Марка / Модель</label><input type="text" id="carMake" placeholder="Например: BMW X5"></div>
                    <div class="form-group"><label>Гос. номер</label><input type="text" id="carPlate" placeholder="А123ВС777"></div>
                    <div class="form-group"><label>Год выпуска</label><input type="number" id="carYear" placeholder="2020"></div>
                    <div class="form-group"><label>Пробег (км)</label><input type="number" id="carMileage" placeholder="125000"></div>
                    <div class="form-group"><label>Дата диагностики</label><input type="date" id="diagDate"></div>
                </div>
                <div style="display:flex; gap:8px; flex-wrap:wrap; min-width:120px;">
                    <button class="btn-success" onclick="saveCarInfo()" style="white-space:nowrap;"><i class="fas fa-save"></i> Сохранить</button>
                    <button class="btn-warning" onclick="clearDiag()" style="white-space:nowrap;"><i class="fas fa-plus"></i> Новая</button>
                </div>
            </div>
            <div class="form-group"><label>Жалобы / Примечания</label><textarea id="carComplaints" rows="2" placeholder="Опишите жалобы клиента..."></textarea></div>
            <div id="saveFeedback" style="margin-top:8px; font-weight:500; color:#1b6d3b;"></div>
        </div>
        <div id="diag2" class="tab-content" style="padding:14px 0 0;">
            <div class="flex-between"><h3 style="color:#0b2b3c;font-size:1rem;"><i class="fas fa-check-circle" style="color:#f6b83d;"></i> Выберите системы</h3><span class="small-note">нажмите на карточку</span></div>
            <div class="card-grid" id="systemsGrid"></div>
            <div style="margin-top:12px; padding:10px; background:#edf4fa; border-radius:10px; color:#1f4a5e; font-size:0.85rem;">
                <i class="fas fa-info-circle"></i> Выбрано систем: <span id="selectedCount">0</span>
            </div>
        </div>
        <div id="diag3" class="tab-content" style="padding:14px 0 0;">
            <h3 style="color:#0b2b3c;font-size:1rem;margin-bottom:8px;"><i class="fas fa-stethoscope" style="color:#f6b83d;"></i> Список выбранных систем</h3>
            <div id="selectedSystemsContainer"></div>
            <div id="emptyDiagMessage" style="color:#4f6f82; background:#edf3fa; padding:20px; border-radius:14px; text-align:center;">Нет выбранных систем.</div>
        </div>
        <div id="diag4" class="tab-content" style="padding:14px 0 0;">
            <div class="flex-between">
                <h3 style="color:#0b2b3c;font-size:1rem;"><i class="fas fa-file-alt" style="color:#f6b83d;"></i> Лист диагностики</h3>
                <div class="no-print" style="display:flex; gap:6px; flex-wrap:wrap;">
                    <button class="btn-success" onclick="saveDiagToJournal()"><i class="fas fa-save"></i> Сохранить</button>
                    <button class="btn-success" onclick="transferToRepair()"><i class="fas fa-arrow-right"></i> В ремонт</button>
                    <button class="btn-primary" onclick="printDiag()"><i class="fas fa-print"></i> Печать</button>
                </div>
            </div>
            <div id="printArea">
                <div id="reportContent" style="margin-top:10px;"></div>
            </div>
            <div id="saveReportFeedback" style="margin-top:8px; font-weight:500; color:#1b6d3b;"></div>
        </div>
    </div>

    <!-- ===== РЕМОНТ ===== -->
    <div id="page-repair" class="tab-content">
        <div class="tabs" style="background:transparent; border-bottom:1px solid #d0d9e4; padding:0;">
            <button class="tab-btn active" data-tab="repair1"><i class="fas fa-edit"></i> Регистрация</button>
            <button class="tab-btn" data-tab="repair2"><i class="fas fa-shopping-cart"></i> Запчасти</button>
            <button class="tab-btn" data-tab="repair3"><i class="fas fa-wrench"></i> Работы</button>
            <button class="tab-btn" data-tab="repair4"><i class="fas fa-file-contract"></i> Акт</button>
        </div>
        <div id="repair1" class="tab-content active" style="padding:14px 0 0;">
            <div class="flex-between" style="margin-bottom:10px;">
                <div class="row-3col" style="flex:1; gap:14px;">
                    <div class="form-group"><label>Марка / Модель</label><input type="text" id="repairMake" placeholder="Например: BMW X5"></div>
                    <div class="form-group"><label>Гос. номер</label><input type="text" id="repairPlate" placeholder="А123ВС777"></div>
                    <div class="form-group"><label>Год выпуска</label><input type="number" id="repairYear" placeholder="2020"></div>
                    <div class="form-group"><label>Пробег (км)</label><input type="number" id="repairMileage" placeholder="125000"></div>
                    <div class="form-group"><label>Дата ремонта</label><input type="date" id="repairDate"></div>
                    <div class="form-group"><label>Скидка</label>
                        <select id="repairDiscount" onchange="updateAct()">
                            <option value="none">Без скидки</option>
                        </select>
                    </div>
                </div>
                <div style="display:flex; gap:8px; flex-wrap:wrap; min-width:120px;">
                    <button class="btn-success" onclick="saveRepairCarInfo()" style="white-space:nowrap;"><i class="fas fa-save"></i> Сохранить</button>
                    <button class="btn-warning" onclick="clearRepair()" style="white-space:nowrap;"><i class="fas fa-plus"></i> Новый</button>
                </div>
            </div>
            <div class="form-group"><label>Жалобы / Примечания</label><textarea id="repairComplaints" rows="2" placeholder="Опишите жалобы клиента..."></textarea></div>
            <div id="repairSaveFeedback" style="margin-top:8px; font-weight:500; color:#1b6d3b;"></div>
        </div>
        <div id="repair2" class="tab-content" style="padding:14px 0 0;">
            <div class="flex-between"><h3 style="color:#0b2b3c;font-size:1rem;"><i class="fas fa-shopping-cart" style="color:#f6b83d;"></i> Запчасти</h3><button class="btn-success" onclick="addPart()"><i class="fas fa-plus"></i> Добавить</button></div>
            <div style="margin-top:10px; overflow-x:auto;">
                <table class="diagnostic-table" id="partsTable">
                    <thead><tr><th>№</th><th>Название</th><th>Кол-во</th><th>Цена (₽)</th><th>Сумма (₽)</th><th>Действия</th></tr></thead>
                    <tbody id="partsBody"></tbody>
                    <tfoot><tr><td colspan="4" class="text-right fw-bold">Итого запчасти:</td><td class="fw-bold" id="partsTotal">0</td><td></td></tr></tfoot>
                </table>
            </div>
        </div>
        <div id="repair3" class="tab-content" style="padding:14px 0 0;">
            <div class="flex-between">
                <h3 style="color:#0b2b3c;font-size:1rem;"><i class="fas fa-wrench" style="color:#f6b83d;"></i> Работы</h3>
                <div>
                    <button class="btn-success" onclick="addWork()"><i class="fas fa-plus"></i> Добавить</button>
                    <button class="btn-primary" onclick="addWorkFromPrice()"><i class="fas fa-list"></i> Из прайса</button>
                </div>
            </div>
            <div style="margin-top:10px; overflow-x:auto;">
                <table class="diagnostic-table works-table" id="worksTable">
                    <thead><tr><th>№</th><th>Наименование работы</th><th>Стоимость (₽)</th><th>Примечание</th><th>Действия</th></tr></thead>
                    <tbody id="worksBody"></tbody>
                    <tfoot><tr><td colspan="2" class="text-right fw-bold">Итого работы:</td><td class="fw-bold" id="worksTotal">0</td><td></td><td></td></tr></tfoot>
                </table>
            </div>
        </div>
        <div id="repair4" class="tab-content" style="padding:14px 0 0;">
            <div class="flex-between">
                <h3 style="color:#0b2b3c;font-size:1rem;"><i class="fas fa-file-contract" style="color:#f6b83d;"></i> Акт выполненных работ</h3>
                <div class="no-print" style="display:flex; gap:6px; flex-wrap:wrap;">
                    <button class="btn-success" onclick="saveRepairToJournal()"><i class="fas fa-save"></i> Сохранить</button>
                    <button class="btn-primary" onclick="printRepair()"><i class="fas fa-print"></i> Печать</button>
                </div>
            </div>
            <div id="printAreaRepair">
                <div id="actContent" style="margin-top:10px;"></div>
            </div>
            <div id="actFeedback" style="margin-top:8px; font-weight:500; color:#1b6d3b;"></div>
        </div>
    </div>

    <!-- ===== ЗАПИСИ ===== -->
    <div id="page-bookings" class="tab-content">
        <h3 style="color:#0b2b3c; margin-bottom:12px;"><i class="fas fa-calendar-check" style="color:#f6b83d;"></i> Записи клиентов</h3>
        
        <div class="bookings-form">
            <div class="row-4col">
                <div class="form-group" style="margin-bottom:0;">
                    <label>Клиент</label>
                    <select id="bk_client" onchange="selectClientForBooking()">
                        <option value="">Выберите клиента...</option>
                    </select>
                </div>
                <div class="form-group" style="margin-bottom:0;"><label>Имя</label><input type="text" id="bk_name" placeholder="Иван Петров"></div>
                <div class="form-group" style="margin-bottom:0;"><label>Телефон</label><input type="text" id="bk_phone" placeholder="+7 999 123-45-67"></div>
                <div class="form-group" style="margin-bottom:0;"><label>Марка</label><input type="text" id="bk_car" placeholder="BMW X5"></div>
                <div class="form-group" style="margin-bottom:0;"><label>Гос. номер</label><input type="text" id="bk_plate" placeholder="А123ВС777"></div>
                <div class="form-group" style="margin-bottom:0;"><label>Дата</label><input type="date" id="bk_date"></div>
                <div class="form-group" style="margin-bottom:0;"><label>Время</label><input type="time" id="bk_time"></div>
                <div class="form-group" style="margin-bottom:0;"><label>Тип</label>
                    <select id="bk_type"><option value="diagnostic">Диагностика</option><option value="repair">Ремонт</option></select>
                </div>
                <div class="form-group" style="margin-bottom:0;"><label>Причина</label><input type="text" id="bk_reason" placeholder="Причина записи"></div>
                <div style="display:flex; align-items:flex-end; gap:6px;">
                    <button class="btn-success" onclick="addBookingFromForm()" style="width:100%;"><i class="fas fa-plus"></i> Добавить</button>
                </div>
            </div>
        </div>
        
        <div class="flex-between" style="margin-bottom:8px;">
            <div style="display:flex; gap:10px; flex-wrap:wrap; align-items:center;">
                <span style="font-size:0.85rem; color:#3a657e;">Всего: <strong id="bookingsTotal">0</strong></span>
                <select id="bookingsFilter" onchange="renderBookings()" style="padding:4px 10px; border:1px solid #d0dce8; border-radius:8px; font-size:0.8rem;">
                    <option value="all">Все записи</option>
                    <option value="новая">Новая</option>
                    <option value="в работе">В работе</option>
                    <option value="ожидается">Ожидается</option>
                    <option value="отремонтирована">Отремонтирована</option>
                    <option value="не отремонтирована">Не отремонтирована</option>
                    <option value="продиагностирована">Продиагностирована</option>
                    <option value="closed">Закрытые</option>
                </select>
            </div>
            <span style="font-size:0.8rem; color:#3a657e;">💾 Данные сохраняются в общий файл</span>
        </div>
        
        <div style="overflow-x:auto;">
            <table class="bookings-table" id="bookingsTable">
                <thead>
                    <tr>
                        <th>№</th>
                        <th>Имя</th>
                        <th>Телефон</th>
                        <th>Гос. номер</th>
                        <th>Дата</th>
                        <th>Время</th>
                        <th>Марка</th>
                        <th>Тип</th>
                        <th>Статус</th>
                        <th>Причина</th>
                        <th>Связь</th>
                        <th>Действия</th>
                    </tr>
                </thead>
                <tbody id="bookingsBody"></tbody>
            </table>
        </div>
        <div id="bookingsFeedback" style="margin-top:10px; font-weight:500; color:#1b6d3b;"></div>
    </div>

    <!-- ===== КЛИЕНТЫ ===== -->
    <div id="page-clients" class="tab-content">
        <div class="flex-between">
            <h3 style="color:#0b2b3c;font-size:1.1rem;">
                <i class="fas fa-users" style="color:#f6b83d;"></i> База клиентов
            </h3>
            <div class="no-print" style="display:flex; gap:6px; flex-wrap:wrap;">
                <button class="btn-success" onclick="addClientForm()">
                    <i class="fas fa-plus"></i> Добавить клиента
                </button>
                <button class="btn-primary" onclick="syncClientCodes()" style="background:#2d6b84;">
                    <i class="fas fa-sync"></i> Синхр. коды
                </button>
                <button class="btn-primary" onclick="restoreClientStats()" style="background:#6c5b7b;">
                    <i class="fas fa-heartbeat"></i> Восст. статистику
                </button>
            </div>
        </div>
        
        <div style="margin-top:12px; overflow-x:auto;">
            <table class="clients-table" id="clientsTable">
                <thead>
                    <tr>
                        <th>№</th>
                        <th>Имя</th>
                        <th>Телефон</th>
                        <th>Гос. номер</th>
                        <th>Марка</th>
                        <th>Код доступа</th>
                        <th>Диагностик</th>
                        <th>Ремонтов</th>
                        <th>Действия</th>
                    </tr>
                </thead>
                <tbody id="clientsBody"></tbody>
            </table>
        </div>
        <div id="clientsFeedback" style="margin-top:10px; font-weight:500; color:#1b6d3b;"></div>
    </div>

    <!-- ===== ПРАЙС-ЛИСТ ===== -->
    <div id="page-prices" class="tab-content">
        <div class="flex-between">
            <h3 style="color:#0b2b3c;font-size:1.1rem;"><i class="fas fa-ruble-sign" style="color:#f6b83d;"></i> Прайс-лист услуг</h3>
            <div class="no-print" style="display:flex; gap:6px; flex-wrap:wrap;">
                <button class="btn-success" onclick="addPriceItem()"><i class="fas fa-plus"></i> Добавить</button>
                <button class="btn-warning" onclick="editPriceMode()"><i class="fas fa-edit"></i> Редактировать</button>
            </div>
        </div>
        <div class="price-search">
            <input type="text" id="priceSearch" placeholder="🔍 Поиск по услугам..." oninput="renderPrices()">
        </div>
        <div id="pricesContainer" style="margin-top:10px;"></div>
        <div id="priceFeedback" style="margin-top:10px; font-weight:500; color:#1b6d3b;"></div>
    </div>

    <!-- ===== ЖУРНАЛ ===== -->
    <div id="page-journal" class="tab-content">
        <h3 style="color:#0b2b3c; margin-bottom:12px;"><i class="fas fa-book" style="color:#f6b83d;"></i> Журнал сохранённых записей</h3>
        
        <div class="journal-filters">
            <select id="journalFilter" onchange="renderJournal()">
                <option value="all">Все записи</option>
                <option value="diagnostic">🔍 Диагностика</option>
                <option value="repair">🔧 Ремонт</option>
            </select>
            <input type="text" id="journalSearch" placeholder="Поиск по авто или номеру..." oninput="renderJournal()">
            <span style="font-size:0.85rem; color:#3a657e; margin-left:auto;" id="journalFilterCount">Найдено: 0</span>
        </div>
        
        <div id="journalList"></div>
        <div id="emptyJournal" style="color:#4f6f82; background:#edf3fa; padding:24px; border-radius:14px; text-align:center;">
            <i class="fas fa-inbox" style="font-size:1.8rem; display:block; margin-bottom:6px;"></i>
            <p>Нет сохранённых записей</p>
        </div>
    </div>

    <!-- ===== ЭТАЛОНЫ ===== -->
    <div id="page-etalons" class="tab-content">
        <div class="flex-between">
            <h3 style="color:#0b2b3c;font-size:1.1rem;"><i class="fas fa-database" style="color:#f6b83d;"></i> Эталонные значения</h3>
            <span style="font-size:0.8rem; color:#3a657e;">💾 Данные сохраняются в общий файл</span>
        </div>
        
        <div class="search-box">
            <input type="text" id="etalonSearch" placeholder="🔍 Поиск по системам и параметрам..." oninput="renderEtalons()">
        </div>
        
        <div id="etalonsContainer" style="margin-top:12px;"></div>
        <div id="etalonsFeedback" style="margin-top:10px; font-weight:500; color:#1b6d3b;"></div>
    </div>

    <!-- ===== НАСТРОЙКИ ===== -->
    <div id="page-settings" class="tab-content">
        <h3 style="color:#0b2b3c; margin-bottom:16px;"><i class="fas fa-cog" style="color:#f6b83d;"></i> Настройки</h3>
        
        <div class="settings-group">
            <h4>💰 Система скидок</h4>
            <div id="discountsContainer">
                <div class="settings-item" style="border-bottom: none;">
                    <span class="param-name">Название скидки</span>
                    <span class="param-name" style="min-width:80px;">Процент</span>
                    <span style="min-width:80px;">Действия</span>
                </div>
                <div id="discountsList"></div>
                <div class="settings-item" style="border-bottom: none; padding-top:10px;">
                    <input type="text" id="newDiscountName" placeholder="Название скидки" style="flex:1; min-width:120px; padding:4px 8px; border:1px solid #d0dce8; border-radius:6px; font-size:0.85rem;">
                    <input type="number" id="newDiscountPercent" placeholder="%" style="width:80px; padding:4px 8px; border:1px solid #d0dce8; border-radius:6px; font-size:0.85rem;">
                    <button class="btn-sm btn-success" onclick="addDiscount()"><i class="fas fa-plus"></i> Добавить</button>
                </div>
            </div>
        </div>
        
        <div id="settingsContainer"></div>
        <div style="margin-top:16px;">
            <button class="btn-success" onclick="addNewSystem()"><i class="fas fa-plus"></i> Добавить новую систему</button>
            <button class="btn-primary" onclick="saveSettings()" style="margin-left:10px;"><i class="fas fa-save"></i> Сохранить настройки</button>
        </div>
        <div id="settingsFeedback" style="margin-top:10px; font-weight:500; color:#1b6d3b;"></div>
    </div>
</div>

<!-- Modal для диагностики -->
<div class="modal-overlay" id="diagModal">
    <div class="modal-box">
        <button class="modal-close" onclick="closeModal()"><i class="fas fa-times"></i></button>
        <div class="modal-title" id="modalSystemTitle">Система</div>
        <div id="modalTableWrapper"></div>
    </div>
</div>

<!-- Modal для выбора работы из прайса -->
<div class="modal-overlay" id="priceSelectModal">
    <div class="modal-box" style="max-width: 800px;">
        <button class="modal-close" onclick="closePriceSelectModal()"><i class="fas fa-times"></i></button>
        <div class="modal-title">📋 Выберите работу из прайс-листа</div>
        <div class="price-search" style="margin:10px 0;">
            <input type="text" id="priceSelectSearch" placeholder="🔍 Поиск..." oninput="renderPriceSelect()">
        </div>
        <div id="priceSelectContainer" style="max-height:500px; overflow-y:auto;"></div>
    </div>
</div>

<!-- Modal для деталей записи -->
<div class="modal-overlay booking-detail-modal" id="bookingDetailModal">
    <div class="modal-box">
        <button class="modal-close" onclick="closeBookingDetailModal()"><i class="fas fa-times"></i></button>
        <div class="modal-title">📋 Детали записи</div>
        <div id="bookingDetailContent"></div>
        <div class="btn-group" style="display:flex; gap:8px; margin-top:12px; flex-wrap:wrap;">
            <button class="btn-success" onclick="insertBookingToDiag()"><i class="fas fa-stethoscope"></i> В диагностику</button>
            <button class="btn-success" onclick="insertBookingToRepair()"><i class="fas fa-tools"></i> В ремонт</button>
            <button class="btn-primary" onclick="closeBookingDetailModal()"><i class="fas fa-times"></i> Закрыть</button>
        </div>
        <div id="bookingInsertFeedback" style="margin-top:8px; font-weight:500; color:#1b6d3b;"></div>
    </div>
</div>

<script>
// ============================================================
// КОНФИГУРАЦИЯ SUPABASE
// ============================================================
const SUPABASE_URL = 'https://xpaqczxqkuzfwmnimzsx.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhwYXFjenhxa3V6ZndtbmltenN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODg5Njg4NDcsImV4cCI6MjEwNDU0NDg0N30.hH62d6aCsgBchg4MVPey714O3-FR9bNaqnsm_T32zAk';

// ============================================================
// СОСТОЯНИЕ ПРИЛОЖЕНИЯ
// ============================================================
let SYSTEMS = [
    { id: 'engine', name: 'Двигатель', desc: 'Ошибки, уровень и цвет масла, шум' },
    { id: 'cooling', name: 'Система охлаждения', desc: 'Термостат, температура ОЖ, уровень и утечки антифриза' },
    { id: 'brakes', name: 'Тормозная система', desc: 'Колодки, диски, жидкость, суппорты, ручник' },
    { id: 'ignition', name: 'Система зажигания', desc: 'Свечи, катушки, пропуски зажигания' },
    { id: 'lights', name: 'Световые приборы', desc: 'Фары, габариты, поворотники, ПТФ, ДХО, подсветка' },
    { id: 'ac', name: 'Кондиционирование', desc: 'Кондиционер, печка, моторчик, заслонки, обдув' },
    { id: 'exhaust', name: 'Выхлопная система', desc: 'Целостность, катализатор, датчики, цвет и запах' },
    { id: 'interior_electronics', name: 'Салонная электроника', desc: 'Свет, приборка, подрулевые, мультируль, мультимедиа, стёкла, замки' },
    { id: 'suspension', name: 'Подвеска', desc: 'ШРУСы, шаровые, рулевые, амортизаторы, пружины, сайлентблоки' }
];

let PARAMS = getDefaultParams();
let systemIdCounter = 100;
let DIAG_TABLES = createEmptyDiagTables();
let selectedSystems = new Set();
let savedCarData = { make: '', plate: '', year: '', mileage: '', date: '', complaints: '' };
let repairCarData = { make: '', plate: '', year: '', mileage: '', date: '', complaints: '', discount: 'none' };
let parts = [];
let works = [];
let partIdCounter = 1;
let workIdCounter = 1;
let journal = [];
let currentFileName = '';
let bookings = [];
let bookingIdCounter = 1;
let etalonData = {};
let clients = [];
let clientIdCounter = 1;
let discounts = [
    { id: 1, name: 'Постоянный клиент', percent: 10 },
    { id: 2, name: 'Акция', percent: 15 }
];
let discountIdCounter = 3;
let priceEditMode = false;
let currentBookingId = null;
let newRequests = [];
let newClients = [];

// ============================================================
// ПРАЙС-ЛИСТ
// ============================================================
let priceData = [
    { category: 'Техническое обслуживание', service: 'Диагностика', domestic: 500, import: 500 },
    { category: 'Техническое обслуживание', service: 'Замена масла в двигателе', domestic: '350–700', import: '350–1000' },
    { category: 'Техническое обслуживание', service: 'Замена воздушного фильтра', domestic: '100–200', import: 'от 200' },
    { category: 'Двигатель', service: 'Замена ремня ГРМ', domestic: '1200–3500', import: '1500–15000' },
    { category: 'Двигатель', service: 'Капитальный ремонт', domestic: 'от 20000', import: 'от 20000' },
    { category: 'Трансмиссия (КПП)', service: 'Замена сцепления', domestic: '3000–6000', import: '3500–15000' },
    { category: 'Тормозная система', service: 'Замена передних колодок', domestic: '500–600', import: '600–2500' },
    { category: 'Электротехнические работы', service: 'Замена генератора', domestic: 500, import: '700–3000' },
    { category: 'Электротехнические работы', service: 'Замена стартера', domestic: '500-700', import: '700–3000' }
];

const CLOSED_STATUSES = ['отремонтирована', 'не отремонтирована', 'продиагностирована'];
const BOOKING_STATUSES = ['новая', 'в работе', 'ожидается', 'отремонтирована', 'не отремонтирована', 'продиагностирована'];

function getDefaultParams() {
    return {
        engine: ['Ошибки двигателя (DTC)', 'Уровень масла', 'Цвет масла', 'Шум из двигателя'],
        cooling: ['Термостат', 'Температура охлаждающей жидкости', 'Уровень антифриза', 'Утечка антифриза'],
        brakes: ['Толщина колодок передних', 'Толщина колодок задних', 'Толщина тормозных дисков передних',
            'Толщина тормозных дисков задних', 'Уровень тормозной жидкости', 'Цвет тормозной жидкости',
            'Утечки тормозной жидкости', 'Заклинивание суппортов', 'Состояние ручного тормоза'],
        ignition: ['Нагар на свечах', 'Зазор на свечах', 'Состояние катушек зажигания', 'Пропуски зажигания'],
        lights: ['Ближний свет', 'Дальний свет', 'Габариты передние', 'Габариты задние',
            'Поворотники', 'ПТФ передние', 'ПТФ задние', 'Фара заднего хода',
            'ДХО (дневные ходовые огни)', 'Подсветка номерного знака'],
        ac: ['Работа кондиционера', 'Работа печки', 'Работа моторчика отопителя',
            'Работа заслонки салон/улица', 'Работа режимов обдува',
            'Посторонние запахи из дефлекторов', 'Работа скоростей моторчика'],
        exhaust: ['Целостность трассы выхлопа', 'Состояние катализатора',
            'Состояние датчиков кислорода', 'Запах выхлопа', 'Цвет выхлопа',
            'Посторонние звуки от выхлопной системы'],
        interior_electronics: ['Свет в салоне', 'Работа приборной панели', 'Работа левого подрулевого лепестка',
            'Работа правого подрулевого лепестка', 'Работа кнопок мультируля',
            'Работа мультимедиа', 'Работа стеклоподъемников', 'Работа центрального замка',
            'Работа кнопок багажника/бесключевого доступа'],
        suspension: ['Состояние ШРУСов', 'Состояние шаровых опор', 'Состояние рулевых наконечников',
            'Состояние амортизаторов', 'Состояние пружин', 'Состояние сайлентблоков',
            'Состояние рычагов', 'Состояние ступичных подшипников', 'Состояние опорных подшипников']
    };
}

function createEmptyDiagTables() {
    const tables = {};
    SYSTEMS.forEach(sys => {
        const params = PARAMS[sys.id] || ['Параметр 1', 'Параметр 2', 'Параметр 3'];
        tables[sys.id] = params.map(p => ({
            param: p,
            value: '',
            status: 'unknown',
            checked: false,
            note: ''
        }));
    });
    return tables;
}

// ============================================================
// ФУНКЦИИ ПЕЧАТИ
// ============================================================
function printDiag() {
    const content = document.getElementById('printArea');
    if (!content || content.innerHTML.trim() === '' || content.innerHTML.includes('Нет выбранных систем')) {
        alert('Нет данных для печати. Сначала заполните диагностику.');
        return;
    }
    window.print();
}

function printRepair() {
    const content = document.getElementById('printAreaRepair');
    if (!content || content.innerHTML.trim() === '' || content.innerHTML.includes('Нет данных')) {
        alert('Нет данных для печати. Сначала заполните ремонт.');
        return;
    }
    window.print();
}

// ============================================================
// РАБОТА С JSON НА СЕРВЕРЕ
// ============================================================
async function loadJsonFromServer() {
    try {
        const response = await fetch(`${SUPABASE_URL}/rest/v1/app_data?key=eq.palych_data&select=data`, {
            headers: {
                'apikey': SUPABASE_ANON_KEY,
                'Authorization': `Bearer ${SUPABASE_ANON_KEY}`
            }
        });
        
        if (response.status === 404) {
            console.warn('⚠️ Таблица app_data не найдена, пробуем создать...');
            const createResponse = await fetch(`${SUPABASE_URL}/rest/v1/app_data`, {
                method: 'POST',
                headers: {
                    'apikey': SUPABASE_ANON_KEY,
                    'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
                    'Content-Type': 'application/json',
                    'Prefer': 'return=representation'
                },
                body: JSON.stringify({
                    key: 'palych_data',
                    data: {
                        version: '4.6',
                        timestamp: new Date().toISOString(),
                        clients: [],
                        bookings: [],
                        journal: [],
                        priceData: [],
                        discounts: [],
                        systems: SYSTEMS,
                        params: PARAMS,
                        diagTables: DIAG_TABLES,
                        selectedSystems: [],
                        savedCarData: { make: '', plate: '', year: '', mileage: '', date: '', complaints: '' },
                        repairCarData: { make: '', plate: '', year: '', mileage: '', date: '', complaints: '', discount: 'none' },
                        parts: [],
                        works: [],
                        etalonData: {},
                        clientIdCounter: 1,
                        bookingIdCounter: 1,
                        partIdCounter: 1,
                        workIdCounter: 1,
                        systemIdCounter: 100,
                        discountIdCounter: 3
                    },
                    updated_at: new Date().toISOString()
                })
            });
            
            if (!createResponse.ok) {
                throw new Error(`Не удалось создать таблицу: ${createResponse.status}`);
            }
            
            console.log('✅ Таблица app_data создана');
            return {
                version: '4.6',
                clients: [],
                bookings: [],
                journal: [],
                priceData: [],
                discounts: [],
                systems: SYSTEMS,
                params: PARAMS,
                diagTables: DIAG_TABLES,
                selectedSystems: [],
                savedCarData: { make: '', plate: '', year: '', mileage: '', date: '', complaints: '' },
                repairCarData: { make: '', plate: '', year: '', mileage: '', date: '', complaints: '', discount: 'none' },
                parts: [],
                works: [],
                etalonData: {},
                clientIdCounter: 1,
                bookingIdCounter: 1,
                partIdCounter: 1,
                workIdCounter: 1,
                systemIdCounter: 100,
                discountIdCounter: 3
            };
        }
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const result = await response.json();
        
        if (result && result.length > 0 && result[0].data) {
            return result[0].data;
        }
        return null;
        
    } catch (error) {
        console.error('❌ Ошибка загрузки JSON с сервера:', error);
        throw error;
    }
}

async function saveJsonToServer(data) {
    try {
        const jsonData = {
            ...data,
            version: '4.6',
            timestamp: new Date().toISOString()
        };
        
        const response = await fetch(`${SUPABASE_URL}/rest/v1/app_data?key=eq.palych_data`, {
            method: 'PATCH',
            headers: {
                'apikey': SUPABASE_ANON_KEY,
                'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
                'Content-Type': 'application/json',
                'Prefer': 'return=representation'
            },
            body: JSON.stringify({
                data: jsonData,
                updated_at: new Date().toISOString()
            })
        });
        
        if (!response.ok) {
            const insertResponse = await fetch(`${SUPABASE_URL}/rest/v1/app_data`, {
                method: 'POST',
                headers: {
                    'apikey': SUPABASE_ANON_KEY,
                    'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
                    'Content-Type': 'application/json',
                    'Prefer': 'return=representation'
                },
                body: JSON.stringify({
                    key: 'palych_data',
                    data: jsonData,
                    updated_at: new Date().toISOString()
                })
            });
            
            if (!insertResponse.ok) {
                throw new Error(`HTTP error! status: ${insertResponse.status}`);
            }
            
            const insertResult = await insertResponse.json();
            console.log('✅ JSON создан на сервере');
            return insertResult;
        }
        
        const result = await response.json();
        console.log('✅ JSON сохранен на сервере');
        return result;
        
    } catch (error) {
        console.error('❌ Ошибка сохранения JSON на сервер:', error);
        throw error;
    }
}

// ============================================================
// ОТПРАВКА НА СЕРВЕР
// ============================================================
window.sendToCloud = async function() {
    const btn = document.querySelector('.cloud-send');
    btn.disabled = true;
    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Отправка...';
    
    try {
        const data = {
            clients: clients,
            bookings: bookings,
            journal: journal,
            priceData: priceData,
            discounts: discounts,
            systems: SYSTEMS,
            params: PARAMS,
            diagTables: DIAG_TABLES,
            selectedSystems: Array.from(selectedSystems),
            savedCarData: savedCarData,
            repairCarData: repairCarData,
            parts: parts,
            works: works,
            etalonData: etalonData,
            clientIdCounter: clientIdCounter,
            bookingIdCounter: bookingIdCounter,
            partIdCounter: partIdCounter,
            workIdCounter: workIdCounter,
            systemIdCounter: systemIdCounter,
            discountIdCounter: discountIdCounter
        };
        
        console.log('📤 Отправка данных на сервер...');
        
        const result = await saveJsonToServer(data);
        
        if (result) {
            alert('✅ Данные успешно отправлены на сервер!');
            document.getElementById('fileStatus').textContent = `☁️ Отправлено на сервер в ${new Date().toLocaleTimeString()}`;
            setTimeout(() => updateFileStatus(), 3000);
        }
        
    } catch (error) {
        console.error('❌ Ошибка отправки:', error);
        alert('❌ Ошибка отправки: ' + error.message);
        document.getElementById('fileStatus').textContent = '❌ Ошибка отправки';
    }
    
    btn.disabled = false;
    btn.innerHTML = '<i class="fas fa-cloud-upload-alt"></i> Отправить';
};

// ============================================================
// ЗАГРУЗКА С СЕРВЕРА
// ============================================================
window.syncFromCloud = async function() {
    const btn = document.querySelector('.cloud-pull');
    btn.disabled = true;
    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Загрузка...';
    
    try {
        const jsonData = await loadJsonFromServer();
        
        if (!jsonData) {
            alert('⚠️ На сервере нет данных');
            btn.disabled = false;
            btn.innerHTML = '<i class="fas fa-cloud-download-alt"></i> Синхр.';
            return;
        }
        
        console.log('📥 Загружены данные с сервера');
        
        if (jsonData.clients) clients = jsonData.clients;
        if (jsonData.bookings) bookings = jsonData.bookings;
        if (jsonData.journal) journal = jsonData.journal;
        if (jsonData.priceData) priceData = jsonData.priceData;
        if (jsonData.discounts) discounts = jsonData.discounts;
        if (jsonData.systems) SYSTEMS = jsonData.systems;
        if (jsonData.params) PARAMS = jsonData.params;
        if (jsonData.diagTables) DIAG_TABLES = jsonData.diagTables;
        if (jsonData.selectedSystems) selectedSystems = new Set(jsonData.selectedSystems);
        if (jsonData.savedCarData) savedCarData = jsonData.savedCarData;
        if (jsonData.repairCarData) repairCarData = jsonData.repairCarData;
        if (jsonData.parts) parts = jsonData.parts;
        if (jsonData.works) works = jsonData.works;
        if (jsonData.etalonData) etalonData = jsonData.etalonData;
        if (jsonData.clientIdCounter) clientIdCounter = jsonData.clientIdCounter;
        if (jsonData.bookingIdCounter) bookingIdCounter = jsonData.bookingIdCounter;
        if (jsonData.partIdCounter) partIdCounter = jsonData.partIdCounter;
        if (jsonData.workIdCounter) workIdCounter = jsonData.workIdCounter;
        if (jsonData.systemIdCounter) systemIdCounter = jsonData.systemIdCounter;
        if (jsonData.discountIdCounter) discountIdCounter = jsonData.discountIdCounter;
        
        renderAll();
        loadNewRequests();
        
        alert(`✅ Данные загружены с сервера!\n\n📋 Загружено:\n• Клиентов: ${jsonData.clients ? jsonData.clients.length : 0}\n• Записей: ${jsonData.bookings ? jsonData.bookings.length : 0}\n• Журнал: ${jsonData.journal ? jsonData.journal.length : 0}`);
        document.getElementById('fileStatus').textContent = `✅ Загружено с сервера`;
        setTimeout(() => updateFileStatus(), 3000);
        
    } catch (error) {
        console.error('❌ Ошибка загрузки:', error);
        alert('❌ Ошибка загрузки с сервера: ' + error.message);
        document.getElementById('fileStatus').textContent = '❌ Ошибка загрузки';
    }
    
    btn.disabled = false;
    btn.innerHTML = '<i class="fas fa-cloud-download-alt"></i> Синхр.';
};

// ============================================================
// РАБОТА С ФАЙЛАМИ
// ============================================================
function saveAllToFile() {
    const data = {
        version: '4.6',
        timestamp: new Date().toISOString(),
        journal: journal,
        diagTables: DIAG_TABLES,
        selectedSystems: Array.from(selectedSystems),
        savedCarData: savedCarData,
        repairCarData: repairCarData,
        parts: parts,
        works: works,
        partIdCounter: partIdCounter,
        workIdCounter: workIdCounter,
        systems: SYSTEMS,
        params: PARAMS,
        systemIdCounter: systemIdCounter,
        bookings: bookings,
        bookingIdCounter: bookingIdCounter,
        etalonData: etalonData,
        clients: clients,
        clientIdCounter: clientIdCounter,
        discounts: discounts,
        discountIdCounter: discountIdCounter,
        priceData: priceData
    };

    const json = JSON.stringify(data, null, 2);
    const blob = new Blob([json], { type: 'application/json' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    const fileName = `palych_data_${new Date().toISOString().slice(0,10)}.json`;
    a.download = fileName;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
    currentFileName = fileName;
    updateFileStatus();
    document.getElementById('fileStatus').textContent = `💾 Сохранено: ${fileName}`;
    setTimeout(() => updateFileStatus(), 3000);
}

function loadFromFile(event) {
    const file = event.target.files[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = function(e) {
        try {
            const data = JSON.parse(e.target.result);
            if (data.version) {
                if (data.journal) journal = data.journal;
                if (data.diagTables) DIAG_TABLES = data.diagTables;
                if (data.selectedSystems) selectedSystems = new Set(data.selectedSystems);
                if (data.savedCarData) savedCarData = data.savedCarData;
                if (data.repairCarData) repairCarData = data.repairCarData;
                if (data.parts) parts = data.parts;
                if (data.works) works = data.works;
                if (data.partIdCounter) partIdCounter = data.partIdCounter;
                if (data.workIdCounter) workIdCounter = data.workIdCounter;
                if (data.systems) SYSTEMS = data.systems;
                if (data.params) PARAMS = data.params;
                if (data.systemIdCounter) systemIdCounter = data.systemIdCounter;
                if (data.bookings) bookings = data.bookings;
                if (data.bookingIdCounter) bookingIdCounter = data.bookingIdCounter;
                if (data.etalonData) etalonData = data.etalonData;
                if (data.clients) clients = data.clients;
                if (data.clientIdCounter) clientIdCounter = data.clientIdCounter;
                if (data.discounts) discounts = data.discounts;
                if (data.discountIdCounter) discountIdCounter = data.discountIdCounter;
                if (data.priceData) priceData = data.priceData;

                currentFileName = file.name;
                updateFileStatus();
                document.getElementById('fileStatus').textContent = `📂 Загружено: ${file.name}`;
                
                renderAll();
                alert('✅ Данные успешно загружены!');
            } else {
                alert('❌ Неверный формат файла');
            }
        } catch(err) {
            alert('❌ Ошибка при загрузке файла: ' + err.message);
        }
    };
    reader.readAsText(file);
    event.target.value = '';
}

function updateFileStatus() {
    const statusEl = document.getElementById('fileStatus');
    const nameEl = document.getElementById('currentFileName');
    const countEl = document.getElementById('journalCount');
    if (currentFileName) {
        statusEl.textContent = `📁 ${currentFileName}`;
        nameEl.textContent = currentFileName;
    } else {
        statusEl.textContent = '📁 Нет открытого файла';
        nameEl.textContent = 'Нет открытого файла';
    }
    if (countEl) countEl.textContent = journal.length;
}

function renderAll() {
    renderSystemsGrid();
    updateDiagnosticsTab();
    updateReport();
    renderParts();
    renderWorks();
    updateAct();
    renderJournal();
    renderSettings();
    renderBookings();
    renderClients();
    renderEtalons();
    renderDiscounts();
    renderPrices();
    updateClientSelect();
    autoSaveToLocalStorage();
    loadNewRequests();
}

// ============================================================
// АВТОСОХРАНЕНИЕ В LOCALSTORAGE
// ============================================================
function autoSaveToLocalStorage() {
    try {
        const data = {
            version: '4.6',
            timestamp: new Date().toISOString(),
            journal: journal,
            diagTables: DIAG_TABLES,
            selectedSystems: Array.from(selectedSystems),
            savedCarData: savedCarData,
            repairCarData: repairCarData,
            parts: parts,
            works: works,
            partIdCounter: partIdCounter,
            workIdCounter: workIdCounter,
            systems: SYSTEMS,
            params: PARAMS,
            systemIdCounter: systemIdCounter,
            bookings: bookings,
            bookingIdCounter: bookingIdCounter,
            etalonData: etalonData,
            clients: clients,
            clientIdCounter: clientIdCounter,
            discounts: discounts,
            discountIdCounter: discountIdCounter,
            priceData: priceData
        };
        localStorage.setItem('palych_auto_save', JSON.stringify(data));
        localStorage.setItem('palych_auto_save_time', new Date().toISOString());
    } catch (e) {
        console.warn('Ошибка автосохранения:', e);
    }
}

function loadFromLocalStorage() {
    try {
        const saved = localStorage.getItem('palych_auto_save');
        if (!saved) return false;
        const data = JSON.parse(saved);
        if (!data.version) return false;
        
        if (data.journal) journal = data.journal;
        if (data.diagTables) DIAG_TABLES = data.diagTables;
        if (data.selectedSystems) selectedSystems = new Set(data.selectedSystems);
        if (data.savedCarData) savedCarData = data.savedCarData;
        if (data.repairCarData) repairCarData = data.repairCarData;
        if (data.parts) parts = data.parts;
        if (data.works) works = data.works;
        if (data.partIdCounter) partIdCounter = data.partIdCounter;
        if (data.workIdCounter) workIdCounter = data.workIdCounter;
        if (data.systems) SYSTEMS = data.systems;
        if (data.params) PARAMS = data.params;
        if (data.systemIdCounter) systemIdCounter = data.systemIdCounter;
        if (data.bookings) bookings = data.bookings;
        if (data.bookingIdCounter) bookingIdCounter = data.bookingIdCounter;
        if (data.etalonData) etalonData = data.etalonData;
        if (data.clients) clients = data.clients;
        if (data.clientIdCounter) clientIdCounter = data.clientIdCounter;
        if (data.discounts) discounts = data.discounts;
        if (data.discountIdCounter) discountIdCounter = data.discountIdCounter;
        if (data.priceData) priceData = data.priceData;
        
        return true;
    } catch (e) {
        console.warn('Ошибка загрузки из localStorage:', e);
        return false;
    }
}

// ============================================================
// НАВИГАЦИЯ
// ============================================================
function goHome() {
    document.querySelectorAll('.tab-content').forEach(tc => tc.classList.remove('active'));
    document.getElementById('page-home').classList.add('active');
    document.querySelectorAll('.nav-buttons button').forEach(b => b.classList.remove('active'));
    document.querySelector('.nav-buttons button:first-child').classList.add('active');
}

function switchMode(mode) {
    document.querySelectorAll('.tab-content').forEach(tc => tc.classList.remove('active'));
    const pageMap = { 
        diag: 'page-diag', 
        repair: 'page-repair', 
        bookings: 'page-bookings',
        clients: 'page-clients',
        prices: 'page-prices',
        journal: 'page-journal', 
        etalons: 'page-etalons', 
        settings: 'page-settings'
    };
    document.getElementById(pageMap[mode]).classList.add('active');
    document.querySelectorAll('.nav-buttons button').forEach(b => b.classList.remove('active'));
    const btns = document.querySelectorAll('.nav-buttons button');
    const idx = { diag: 1, repair: 2, bookings: 3, clients: 4, prices: 5, journal: 6, etalons: 7, settings: 8 };
    if (btns[idx[mode]]) btns[idx[mode]].classList.add('active');
    if (mode === 'diag') { renderSystemsGrid(); updateDiagnosticsTab(); updateReport(); }
    if (mode === 'repair') { renderParts(); renderWorks(); updateAct(); renderDiscounts(); }
    if (mode === 'bookings') { renderBookings(); updateClientSelect(); }
    if (mode === 'clients') renderClients();
    if (mode === 'prices') renderPrices();
    if (mode === 'journal') renderJournal();
    if (mode === 'etalons') renderEtalons();
    if (mode === 'settings') { renderSettings(); renderDiscounts(); }
}

// ============================================================
// ОЧИСТКА
// ============================================================
function clearDiag() {
    if (!confirm('Очистить все поля диагностики? (данные не будут сохранены)')) return;
    document.getElementById('carMake').value = '';
    document.getElementById('carPlate').value = '';
    document.getElementById('carYear').value = '';
    document.getElementById('carMileage').value = '';
    document.getElementById('carComplaints').value = '';
    document.getElementById('diagDate').value = new Date().toISOString().slice(0,10);
    savedCarData = { make: '', plate: '', year: '', mileage: '', date: '', complaints: '' };
    selectedSystems = new Set();
    DIAG_TABLES = createEmptyDiagTables();
    renderSystemsGrid();
    updateDiagnosticsTab();
    updateReport();
    document.getElementById('saveFeedback').innerHTML = `<i class="fas fa-check-circle" style="color:#2a8b5a;"></i> Диагностика очищена`;
    setTimeout(() => document.getElementById('saveFeedback').innerHTML = '', 2000);
}

function clearRepair() {
    if (!confirm('Очистить все поля ремонта? (данные не будут сохранены)')) return;
    document.getElementById('repairMake').value = '';
    document.getElementById('repairPlate').value = '';
    document.getElementById('repairYear').value = '';
    document.getElementById('repairMileage').value = '';
    document.getElementById('repairComplaints').value = '';
    document.getElementById('repairDate').value = new Date().toISOString().slice(0,10);
    document.getElementById('repairDiscount').value = 'none';
    repairCarData = { make: '', plate: '', year: '', mileage: '', date: '', complaints: '', discount: 'none' };
    parts = [];
    works = [];
    partIdCounter = 1;
    workIdCounter = 1;
    renderParts();
    renderWorks();
    updateAct();
    document.getElementById('repairSaveFeedback').innerHTML = `<i class="fas fa-check-circle" style="color:#2a8b5a;"></i> Ремонт очищен`;
    setTimeout(() => document.getElementById('repairSaveFeedback').innerHTML = '', 2000);
}

// ============================================================
// ДИАГНОСТИКА
// ============================================================
function renderSystemsGrid() {
    const grid = document.getElementById('systemsGrid');
    if (!grid) return;
    grid.innerHTML = '';
    SYSTEMS.forEach(sys => {
        const isChecked = selectedSystems.has(sys.id);
        const card = document.createElement('div');
        card.className = 'system-card';
        card.style.borderLeft = isChecked ? '4px solid #f6b83d' : '4px solid transparent';
        card.innerHTML = `<div class="title"><span>${sys.name}</span><span class="badge"><i class="fas ${isChecked ? 'fa-check-circle' : 'fa-circle'}"></i> ${isChecked ? 'выбрана' : 'выбрать'}</span></div><div class="desc">${sys.desc}</div>`;
        card.addEventListener('click', () => { toggleSystem(sys.id); });
        grid.appendChild(card);
    });
    updateSelectedCount();
    updateDiagnosticsTab();
    updateReport();
}

function toggleSystem(sysId) {
    if (selectedSystems.has(sysId)) selectedSystems.delete(sysId);
    else selectedSystems.add(sysId);
    renderSystemsGrid();
    updateDiagnosticsTab();
    updateReport();
}

function updateSelectedCount() {
    const el = document.getElementById('selectedCount');
    if (el) el.textContent = selectedSystems.size;
}

function updateDiagnosticsTab() {
    const container = document.getElementById('selectedSystemsContainer');
    const emptyMsg = document.getElementById('emptyDiagMessage');
    if (!container) return;
    container.innerHTML = '';
    if (selectedSystems.size === 0) { if (emptyMsg) emptyMsg.style.display = 'block'; return; }
    if (emptyMsg) emptyMsg.style.display = 'none';
    Array.from(selectedSystems).forEach(id => {
        const sys = SYSTEMS.find(s => s.id === id);
        if (!sys) return;
        const box = document.createElement('div');
        box.className = 'system-card';
        box.style.marginBottom = '6px';
        box.innerHTML = `
            <div class="title"><span><i class="fas fa-car" style="color:#f6b83d;"></i> ${sys.name}</span><span class="badge"><i class="fas fa-clipboard"></i> нажмите</span></div>
            <div style="display:flex; gap:8px; margin-top:4px; flex-wrap:wrap;">
                <button class="btn-sm" style="background:#0b2b3c;color:white;padding:4px 14px;border-radius:30px;border:none;cursor:pointer;" onclick="event.stopPropagation(); openModalForSystem('${sys.id}')"><i class="fas fa-table"></i> Открыть</button>
                <button class="btn-sm" style="background:#b33c3c;color:white;padding:4px 14px;border-radius:30px;border:none;cursor:pointer;" onclick="event.stopPropagation(); toggleSystem('${sys.id}')"><i class="fas fa-times"></i> Убрать</button>
            </div>
        `;
        box.addEventListener('click', () => openModalForSystem(sys.id));
        container.appendChild(box);
    });
}

function getEtalonHint(sysId, paramName) {
    try {
        const saved = localStorage.getItem('palych_etalons');
        if (saved) {
            const freshData = JSON.parse(saved);
            if (freshData && freshData[sysId] && freshData[sysId][paramName]) {
                const e = freshData[sysId][paramName];
                let hint = '📊 Норма: ' + (e.norm || 'не указана');
                if (e.note) hint += ' | 📝 ' + e.note;
                return hint;
            }
        }
    } catch(e) {}
    if (etalonData && etalonData[sysId] && etalonData[sysId][paramName]) {
        const e = etalonData[sysId][paramName];
        let hint = '📊 Норма: ' + (e.norm || 'не указана');
        if (e.note) hint += ' | 📝 ' + e.note;
        return hint;
    }
    return null;
}

function openModalForSystem(sysId) {
    const sys = SYSTEMS.find(s => s.id === sysId);
    if (!sys) return;
    loadEtalons();
    const modal = document.getElementById('diagModal');
    document.getElementById('modalSystemTitle').textContent = `🔧 ${sys.name}`;
    const wrapper = document.getElementById('modalTableWrapper');
    const tableData = DIAG_TABLES[sysId] || [];
    let html = `<table class="diagnostic-table"><thead><tr><th style="width:30px;">№</th><th>Параметр</th><th style="width:150px;">Значение</th><th style="width:120px;">Статус</th><th style="width:40px;text-align:center;">Диагн.</th><th style="min-width:110px;">Примечание</th></tr></thead><tbody>`;
    tableData.forEach((row, idx) => {
        const checkedAttr = row.checked ? 'checked' : '';
        const etalonHint = getEtalonHint(sysId, row.param);
        const statusClass = row.status === 'ok' ? 'active-ok' : row.status === 'fail' ? 'active-fail' : 'active-unknown';
        const statusIcon = row.status === 'ok' ? 'fa-check' : row.status === 'fail' ? 'fa-times' : 'fa-question';
        html += `<tr>
            <td>${idx+1}</td>
            <td>
                <div class="param-with-etalon">
                    <span class="param-name">${row.param}</span>
                    ${etalonHint ? `<span class="etalon-hint" title="${etalonHint}">📊</span>` : ''}
                </div>
            </td>
            <td><input type="text" id="val_${sysId}_${idx}" value="${row.value}" oninput="autoCheckDiag('${sysId}',${idx})"></td>
            <td>
                <div class="status-icons">
                    <div class="status-icon ${row.status === 'ok' ? 'active-ok' : ''}" onclick="setStatus('${sysId}',${idx},'ok')" title="Норма">
                        <i class="fas fa-check"></i>
                    </div>
                    <div class="status-icon ${row.status === 'fail' ? 'active-fail' : ''}" onclick="setStatus('${sysId}',${idx},'fail')" title="Поломка">
                        <i class="fas fa-times"></i>
                    </div>
                    <div class="status-icon ${row.status === 'unknown' ? 'active-unknown' : ''}" onclick="setStatus('${sysId}',${idx},'unknown')" title="Не определено">
                        <i class="fas fa-question"></i>
                    </div>
                </div>
            </td>
            <td style="text-align:center;"><input type="checkbox" id="check_${sysId}_${idx}" ${checkedAttr}></td>
            <td><textarea id="note_${sysId}_${idx}" rows="1">${row.note||''}</textarea></td>
        </tr>`;
    });
    html += `</tbody></table>
        <div style="margin-top:12px; display:flex; gap:8px; flex-wrap:wrap;">
            <button class="btn-primary" style="padding:8px 20px;" onclick="saveDiagTable('${sysId}')"><i class="fas fa-save"></i> Сохранить</button>
            <button class="btn-sm" style="background:#b33c3c;color:white;padding:4px 14px;border-radius:30px;border:none;cursor:pointer;" onclick="closeModal()"><i class="fas fa-times"></i> Закрыть</button>
            <span style="font-size:0.75rem;color:#3a657e;margin-left:auto;"><i class="fas fa-info-circle"></i> 📊 - эталонное значение</span>
        </div>
        <div id="saveTableFeedback" style="margin-top:8px; color:#1a6d3b;"></div>
    `;
    wrapper.innerHTML = html;
    modal.classList.add('active');
}

function setStatus(sysId, idx, status) {
    const row = DIAG_TABLES[sysId][idx];
    if (row) {
        row.status = status;
        const icons = document.querySelectorAll(`#diagModal .status-icon`);
        const startIdx = idx * 3;
        icons.forEach((icon, i) => {
            if (i >= startIdx && i < startIdx + 3) {
                icon.className = 'status-icon';
                if (i === startIdx && status === 'ok') icon.classList.add('active-ok');
                else if (i === startIdx + 1 && status === 'fail') icon.classList.add('active-fail');
                else if (i === startIdx + 2 && status === 'unknown') icon.classList.add('active-unknown');
            }
        });
    }
}

function autoCheckDiag(sysId, idx) {
    const val = document.getElementById(`val_${sysId}_${idx}`);
    const chk = document.getElementById(`check_${sysId}_${idx}`);
    if (val && chk) chk.checked = val.value.trim() !== '';
}

function saveDiagTable(sysId) {
    const tableData = DIAG_TABLES[sysId];
    if (!tableData) return;
    let updated = 0;
    tableData.forEach((row, idx) => {
        const val = document.getElementById(`val_${sysId}_${idx}`);
        const chk = document.getElementById(`check_${sysId}_${idx}`);
        const note = document.getElementById(`note_${sysId}_${idx}`);
        if (val) { row.value = val.value.trim(); if (chk) chk.checked = row.value !== ''; }
        if (chk) row.checked = chk.checked;
        if (note) row.note = note.value;
        updated++;
    });
    saveEtalons();
    document.getElementById('saveTableFeedback').innerHTML = `<i class="fas fa-check-circle" style="color:#2a8b5a;"></i> Сохранено (${updated} параметров)`;
    setTimeout(() => { document.getElementById('saveTableFeedback').innerHTML = ''; }, 2000);
    updateReport();
    const sys = SYSTEMS.find(s => s.id === sysId);
    if (sys) openModalForSystem(sysId);
}

function closeModal() {
    document.getElementById('diagModal').classList.remove('active');
}
document.getElementById('diagModal').addEventListener('click', function(e) {
    if (e.target === this) closeModal();
});

function saveCarInfo() {
    savedCarData = {
        make: document.getElementById('carMake').value.trim() || 'не указано',
        plate: document.getElementById('carPlate').value.trim() || 'не указан',
        year: document.getElementById('carYear').value || '----',
        mileage: document.getElementById('carMileage').value || '0',
        date: document.getElementById('diagDate').value || '----',
        complaints: document.getElementById('carComplaints').value.trim() || '—'
    };
    document.getElementById('saveFeedback').innerHTML = `<i class="fas fa-check-circle" style="color:#2a8b5a;"></i> Данные сохранены`;
    updateReport();
    updateClientStats();
    autoSaveToLocalStorage();
}

// ============================================================
// ЛИСТ ДИАГНОСТИКИ
// ============================================================
function updateReport() {
    const container = document.getElementById('reportContent');
    if (!container) return;
    const selectedIds = Array.from(selectedSystems);
    let html = `<div style="background:white; border-radius:12px; padding:20px; border:2px solid #0b2b3c;">`;
    html += `<div style="text-align:center; border-bottom:3px double #0b2b3c; padding-bottom:10px; margin-bottom:14px;">
        <h2 style="font-size:1.4rem; color:#0b2b3c;">🔧 PalЫCH Car Diagnost</h2>
        <div style="color:#3a657e; font-size:0.95rem;">Лист диагностики автомобиля</div>
    </div>`;
    html += `<div style="display:grid; grid-template-columns:1fr 1fr 1fr; gap:4px 20px; background:#f8fafc; padding:10px 14px; border-radius:8px; margin-bottom:14px; border-left:4px solid #f6b83d;">
        <div><span style="font-weight:600;color:#1f4055;">Марка/Модель:</span> ${savedCarData.make}</div>
        <div><span style="font-weight:600;color:#1f4055;">Гос. номер:</span> <span class="plate-badge">${savedCarData.plate}</span></div>
        <div><span style="font-weight:600;color:#1f4055;">Год:</span> ${savedCarData.year}</div>
        <div><span style="font-weight:600;color:#1f4055;">Пробег:</span> ${savedCarData.mileage} км</div>
        <div><span style="font-weight:600;color:#1f4055;">Дата:</span> ${savedCarData.date}</div>
        <div style="grid-column:1/-1;"><span style="font-weight:600;color:#1f4055;">Жалобы:</span> ${savedCarData.complaints}</div>
    </div>`;
    if (selectedIds.length === 0) {
        html += `<div style="text-align:center;padding:30px;color:#4a6f82;">Нет выбранных систем</div>`;
    } else {
        selectedIds.forEach(id => {
            const sys = SYSTEMS.find(s => s.id === id);
            if (!sys) return;
            const items = (DIAG_TABLES[id] || []).filter(r => r.checked && r.value.trim() !== '');
            if (items.length === 0) return;
            html += `<div style="margin-top:14px; border:1px solid #e4ecf4; border-radius:8px; overflow:hidden;">
                <div style="background:#0b2b3c; color:white; padding:8px 14px; font-weight:700;">🔧 ${sys.name}</div>
                <div style="padding:4px 0;">
                    <div style="display:grid; grid-template-columns:2fr 1fr 1fr 0.8fr; padding:6px 12px; background:#eef3f8; font-weight:700; font-size:0.75rem; color:#1f4055; border-bottom:2px solid #d0dce8;">
                        <span>Параметр</span><span>Значение</span><span>Статус</span><span>Примечание</span>
                    </div>`;
            items.forEach(row => {
                const statusText = row.status === 'ok' ? '✅ норма' : row.status === 'fail' ? '⚠️ поломка' : '❓ не опр.';
                const bg = row.status === 'ok' ? '#d3f0d8' : row.status === 'fail' ? '#fadad8' : '#e8ecf0';
                const color = row.status === 'ok' ? '#0a6030' : row.status === 'fail' ? '#a12b2b' : '#4a5e6b';
                html += `<div style="display:grid; grid-template-columns:2fr 1fr 1fr 0.8fr; padding:6px 12px; border-bottom:1px solid #eef2f7; font-size:0.85rem; align-items:center;">
                    <span style="font-weight:600;color:#0b2b3c;">${row.param}</span>
                    <span>${row.value}</span>
                    <span><span style="display:inline-block; padding:2px 10px; border-radius:30px; font-size:0.7rem; font-weight:600; background:${bg}; color:${color};">${statusText}</span></span>
                    <span style="color:#3a657e; font-size:0.8rem; font-style:italic;">${row.note||''}</span>
                </div>`;
            });
            html += `</div></div>`;
        });
    }
    html += `<div style="margin-top:16px; padding-top:12px; border-top:2px solid #e4ecf4; display:flex; justify-content:flex-end; font-size:0.8rem; color:#3a657e;">
        <span>${new Date().toLocaleString()}</span>
    </div></div>`;
    container.innerHTML = html;
}

// ============================================================
// ПЕРЕНОС В РЕМОНТ
// ============================================================
function transferToRepair() {
    if (!savedCarData.make || savedCarData.make === 'не указано') {
        alert('Сначала заполните данные автомобиля в диагностике!');
        return;
    }
    let complaints = savedCarData.complaints || '';
    let failures = [];
    Array.from(selectedSystems).forEach(id => {
        const sys = SYSTEMS.find(s => s.id === id);
        if (!sys) return;
        const items = DIAG_TABLES[id] || [];
        items.forEach(row => {
            if (row.checked && row.value.trim() !== '' && row.status === 'fail') {
                failures.push(`${sys.name} → ${row.param}: ${row.value}`);
            }
        });
    });
    if (failures.length > 0) {
        if (complaints) complaints += '\n\n--- Выявленные неисправности ---\n';
        complaints += failures.join('\n');
    }
    document.getElementById('repairMake').value = savedCarData.make;
    document.getElementById('repairPlate').value = savedCarData.plate;
    document.getElementById('repairYear').value = savedCarData.year;
    document.getElementById('repairMileage').value = savedCarData.mileage;
    document.getElementById('repairDate').value = savedCarData.date;
    document.getElementById('repairComplaints').value = complaints;
    document.getElementById('repairDiscount').value = 'none';
    repairCarData = {
        make: savedCarData.make,
        plate: savedCarData.plate,
        year: savedCarData.year,
        mileage: savedCarData.mileage,
        date: savedCarData.date,
        complaints: complaints,
        discount: 'none'
    };
    document.getElementById('repairSaveFeedback').innerHTML = `<i class="fas fa-check-circle" style="color:#2a8b5a;"></i> Данные перенесены в ремонт! (${failures.length} неисправностей)`;
    setTimeout(() => document.getElementById('repairSaveFeedback').innerHTML = '', 4000);
    switchMode('repair');
    document.querySelectorAll('#page-repair .tabs .tab-btn').forEach(b => b.classList.remove('active'));
    document.querySelector('#page-repair .tabs .tab-btn[data-tab="repair1"]').classList.add('active');
    document.querySelectorAll('#page-repair .tab-content').forEach(tc => tc.classList.remove('active'));
    document.getElementById('repair1').classList.add('active');
    renderDiscounts();
}

// ============================================================
// СОХРАНЕНИЕ ДИАГНОСТИКИ В ЖУРНАЛ
// ============================================================
function saveDiagToJournal() {
    const selectedIds = Array.from(selectedSystems);
    if (selectedIds.length === 0) { 
        alert('Нет данных для сохранения'); 
        return; 
    }
    
    let clientId = null;
    const plate = savedCarData.plate;
    const name = savedCarData.make;
    
    if (plate && plate !== 'не указан') {
        const foundClient = clients.find(c => c.plate === plate);
        if (foundClient) {
            clientId = foundClient.id;
        }
    }
    
    if (!clientId && name && name !== 'не указано') {
        const foundClient = clients.find(c => c.name === name);
        if (foundClient) {
            clientId = foundClient.id;
        }
    }
    
    const entry = {
        id: Date.now(),
        type: 'diagnostic',
        date: savedCarData.date || new Date().toISOString().slice(0,10),
        car: savedCarData.make || 'не указано',
        plate: savedCarData.plate || 'не указан',
        systems: selectedIds,
        tables: JSON.parse(JSON.stringify(DIAG_TABLES)),
        carData: JSON.parse(JSON.stringify(savedCarData)),
        clientId: clientId,
        timestamp: new Date().toISOString()
    };
    journal.push(entry);
    document.getElementById('saveReportFeedback').innerHTML = `<i class="fas fa-check-circle" style="color:#2a8b5a;"></i> Диагностика сохранена в журнал.`;
    setTimeout(() => { document.getElementById('saveReportFeedback').innerHTML = ''; }, 3000);
    renderJournal();
    updateFileStatus();
    updateClientStats();
    autoSaveToLocalStorage();
}

// ============================================================
// СОХРАНЕНИЕ РЕМОНТА В ЖУРНАЛ
// ============================================================
function saveRepairToJournal() {
    if (parts.length === 0 && works.length === 0) { 
        alert('Нет данных для сохранения (добавьте запчасти или работы)'); 
        return; 
    }
    
    let clientId = null;
    const plate = repairCarData.plate;
    const name = repairCarData.make;
    
    if (plate && plate !== 'не указан') {
        const foundClient = clients.find(c => c.plate === plate);
        if (foundClient) {
            clientId = foundClient.id;
        }
    }
    
    if (!clientId && name && name !== 'не указано') {
        const foundClient = clients.find(c => c.name === name);
        if (foundClient) {
            clientId = foundClient.id;
        }
    }
    
    const entry = {
        id: Date.now(),
        type: 'repair',
        date: repairCarData.date || new Date().toISOString().slice(0,10),
        car: repairCarData.make || 'не указано',
        plate: repairCarData.plate || 'не указан',
        parts: JSON.parse(JSON.stringify(parts)),
        works: JSON.parse(JSON.stringify(works)),
        carData: JSON.parse(JSON.stringify(repairCarData)),
        clientId: clientId,
        timestamp: new Date().toISOString()
    };
    journal.push(entry);
    document.getElementById('actFeedback').innerHTML = `<i class="fas fa-check-circle" style="color:#2a8b5a;"></i> Акт сохранён в журнал.`;
    setTimeout(() => { document.getElementById('actFeedback').innerHTML = ''; }, 3000);
    renderJournal();
    updateFileStatus();
    updateClientStats();
    autoSaveToLocalStorage();
}

// ============================================================
// РЕМОНТ
// ============================================================
function saveRepairCarInfo() {
    repairCarData = {
        make: document.getElementById('repairMake').value.trim() || 'не указано',
        plate: document.getElementById('repairPlate').value.trim() || 'не указан',
        year: document.getElementById('repairYear').value || '----',
        mileage: document.getElementById('repairMileage').value || '0',
        date: document.getElementById('repairDate').value || '----',
        complaints: document.getElementById('repairComplaints').value.trim() || '—',
        discount: document.getElementById('repairDiscount').value || 'none'
    };
    document.getElementById('repairSaveFeedback').innerHTML = `<i class="fas fa-check-circle" style="color:#2a8b5a;"></i> Данные сохранены`;
    updateAct();
    autoSaveToLocalStorage();
}

function renderParts() {
    const tbody = document.getElementById('partsBody');
    if (!tbody) return;
    tbody.innerHTML = '';
    let total = 0;
    parts.forEach((p, idx) => {
        const sum = p.qty * p.price;
        total += sum;
        tbody.innerHTML += `<tr>
            <td>${idx+1}</td>
            <td><input type="text" value="${p.name}" onchange="updatePart(${p.id},'name',this.value)"></td>
            <td><input type="number" value="${p.qty}" onchange="updatePart(${p.id},'qty',parseInt(this.value)||0)" style="width:60px;"></td>
            <td><input type="number" value="${p.price}" onchange="updatePart(${p.id},'price',parseFloat(this.value)||0)" style="width:80px;"></td>
            <td>${sum}</td>
            <td><button class="btn-danger" onclick="removePart(${p.id})"><i class="fas fa-trash"></i></button></td>
        </tr>`;
    });
    document.getElementById('partsTotal').textContent = total;
}

function updatePart(id, field, value) {
    const p = parts.find(x => x.id === id);
    if (p) { p[field] = value; renderParts(); updateAct(); autoSaveToLocalStorage(); }
}

function removePart(id) {
    parts = parts.filter(p => p.id !== id);
    renderParts(); updateAct(); autoSaveToLocalStorage();
}

function addPart() {
    parts.push({ id: partIdCounter++, name: 'Новая запчасть', qty: 1, price: 0 });
    renderParts(); updateAct(); autoSaveToLocalStorage();
}

function renderWorks() {
    const tbody = document.getElementById('worksBody');
    if (!tbody) return;
    tbody.innerHTML = '';
    let total = 0;
    works.forEach((w, idx) => {
        total += w.cost;
        tbody.innerHTML += `<tr>
            <td>${idx+1}</td>
            <td><input type="text" value="${w.name}" onchange="updateWork(${w.id},'name',this.value)"></td>
            <td><input type="number" value="${w.cost}" onchange="updateWork(${w.id},'cost',parseFloat(this.value)||0)" style="width:80px;"></td>
            <td><input type="text" value="${w.note||''}" onchange="updateWork(${w.id},'note',this.value)" placeholder="Примечание" class="work-note" style="width:100%;padding:4px 6px;border:1px solid #d0dce8;border-radius:6px;font-size:0.8rem;"></td>
            <td><button class="btn-danger" onclick="removeWork(${w.id})"><i class="fas fa-trash"></i></button></td>
        </tr>`;
    });
    document.getElementById('worksTotal').textContent = total;
}

function updateWork(id, field, value) {
    const w = works.find(x => x.id === id);
    if (w) { w[field] = value; renderWorks(); updateAct(); autoSaveToLocalStorage(); }
}

function removeWork(id) {
    works = works.filter(w => w.id !== id);
    renderWorks(); updateAct(); autoSaveToLocalStorage();
}

function addWork() {
    works.push({ id: workIdCounter++, name: 'Новая работа', cost: 0, note: '' });
    renderWorks(); updateAct(); autoSaveToLocalStorage();
}

function addWorkFromPrice() {
    const modal = document.getElementById('priceSelectModal');
    modal.classList.add('active');
    renderPriceSelect();
}

function renderPriceSelect() {
    const container = document.getElementById('priceSelectContainer');
    if (!container) return;
    const search = document.getElementById('priceSelectSearch').value.toLowerCase().trim();
    let filtered = priceData;
    if (search) {
        filtered = filtered.filter(p => p.service.toLowerCase().includes(search));
    }
    
    if (filtered.length === 0) {
        container.innerHTML = `<div style="padding:20px; text-align:center; color:#4a6f82;">Нет услуг</div>`;
        return;
    }
    
    let html = '';
    filtered.forEach(item => {
        const price = item.domestic !== null ? item.domestic : (item.import || '—');
        html += `
            <div style="display:grid; grid-template-columns:2fr 1fr 0.5fr; padding:8px 12px; border-bottom:1px solid #eef2f7; align-items:center; cursor:pointer; transition:0.2s;" 
                 onclick="selectWorkFromPrice('${item.service.replace(/'/g,"\\'")}', '${price}')"
                 onmouseover="this.style.background='#f8fafc'" onmouseout="this.style.background='white'">
                <span style="font-weight:600;color:#0b2b3c;">${item.service}</span>
                <span style="color:#1f7b4a;">${price} ₽</span>
                <span style="color:#3a657e;font-size:0.7rem;">${item.category}</span>
            </div>
        `;
    });
    container.innerHTML = html;
}

function selectWorkFromPrice(name, price) {
    const cost = parseFloat(price) || 0;
    works.push({ id: workIdCounter++, name: name, cost: cost, note: '' });
    renderWorks();
    updateAct();
    closePriceSelectModal();
    document.getElementById('actFeedback').innerHTML = `<i class="fas fa-check-circle" style="color:#2a8b5a;"></i> Работа добавлена из прайса`;
    setTimeout(() => document.getElementById('actFeedback').innerHTML = '', 2000);
    autoSaveToLocalStorage();
}

function closePriceSelectModal() {
    document.getElementById('priceSelectModal').classList.remove('active');
}

// ============================================================
// АКТ
// ============================================================
function updateAct() {
    const container = document.getElementById('actContent');
    if (!container) return;
    
    const partsTotal = parts.reduce((sum, p) => sum + p.qty * p.price, 0);
    const worksTotal = works.reduce((sum, w) => sum + w.cost, 0);
    
    let discountPercent = 0;
    let discountName = 'Нет';
    const discountValue = document.getElementById('repairDiscount').value;
    if (discountValue !== 'none') {
        const discount = discounts.find(d => d.id === parseInt(discountValue));
        if (discount) {
            discountPercent = discount.percent;
            discountName = discount.name;
        }
    }
    
    const discountAmount = worksTotal * (discountPercent / 100);
    const worksTotalWithDiscount = worksTotal - discountAmount;
    const grandTotal = partsTotal + worksTotalWithDiscount;

    let html = `<div style="background:white; border-radius:12px; padding:20px; border:2px solid #0b2b3c;">
        <div style="text-align:center; border-bottom:3px double #0b2b3c; padding-bottom:10px; margin-bottom:14px;">
            <h2 style="font-size:1.4rem; color:#0b2b3c;">АКТ ВЫПОЛНЕННЫХ РАБОТ</h2>
            <div style="color:#3a657e; font-size:0.95rem;">По ремонту автомобиля</div>
        </div>
        <div style="display:grid; grid-template-columns:1fr 1fr 1fr; gap:4px 20px; background:#f8fafc; padding:10px 14px; border-radius:8px; margin-bottom:14px; border-left:4px solid #f6b83d;">
            <div><span style="font-weight:600;color:#1f4055;">Марка/Модель:</span> ${repairCarData.make}</div>
            <div><span style="font-weight:600;color:#1f4055;">Гос. номер:</span> <span class="plate-badge">${repairCarData.plate}</span></div>
            <div><span style="font-weight:600;color:#1f4055;">Год:</span> ${repairCarData.year}</div>
            <div><span style="font-weight:600;color:#1f4055;">Пробег:</span> ${repairCarData.mileage} км</div>
            <div><span style="font-weight:600;color:#1f4055;">Дата ремонта:</span> ${repairCarData.date}</div>
            <div style="grid-column:1/-1;"><span style="font-weight:600;color:#1f4055;">Жалобы:</span> ${repairCarData.complaints}</div>
            <div style="grid-column:1/-1;"><span style="font-weight:600;color:#1f4055;">Скидка:</span> <span class="discount-badge">${discountName} (${discountPercent}%)</span></div>
        </div>`;

    html += `<div style="margin-top:12px;"><h4 style="color:#0b2b3c; background:#eef3f8; padding:5px 10px; border-radius:6px; margin-bottom:4px;">📦 Использованные запчасти</h4>`;
    if (parts.length === 0) { html += `<div style="padding:6px 12px; color:#4a6f82;">Нет запчастей</div>`; }
    else {
        html += `<div style="display:grid; grid-template-columns:3fr 1fr 1fr; padding:4px 10px; background:#e4ecf4; font-weight:700; color:#1f4055; font-size:0.82rem; border-radius:4px;"><span>Наименование</span><span>Кол-во</span><span>Цена</span></div>`;
        parts.forEach(p => {
            html += `<div style="display:grid; grid-template-columns:3fr 1fr 1fr; padding:4px 10px; border-bottom:1px solid #eef2f7; font-size:0.82rem;"><span>${p.name}</span><span>${p.qty} шт.</span><span>${p.qty * p.price} ₽</span></div>`;
        });
        html += `<div style="text-align:right; font-weight:700; font-size:0.95rem; padding:8px 0; border-top:2px solid #0b2b3c; margin-top:8px;">Итого запчасти: ${partsTotal} ₽</div>`;
    }
    html += `</div>`;

    html += `<div style="margin-top:12px;"><h4 style="color:#0b2b3c; background:#eef3f8; padding:5px 10px; border-radius:6px; margin-bottom:4px;">🔧 Выполненные работы</h4>`;
    if (works.length === 0) { html += `<div style="padding:6px 12px; color:#4a6f82;">Нет работ</div>`; }
    else {
        html += `<div style="display:grid; grid-template-columns:2.5fr 1fr 1fr; padding:4px 10px; background:#e4ecf4; font-weight:700; color:#1f4055; font-size:0.82rem; border-radius:4px;"><span>Наименование работы</span><span>Примечание</span><span>Стоимость</span></div>`;
        works.forEach(w => {
            html += `<div style="display:grid; grid-template-columns:2.5fr 1fr 1fr; padding:4px 10px; border-bottom:1px solid #eef2f7; font-size:0.82rem;">
                <span>${w.name}</span>
                <span style="color:#3a657e;font-size:0.75rem;font-style:italic;">${w.note || ''}</span>
                <span>${w.cost} ₽</span>
            </div>`;
        });
        html += `<div style="text-align:right; font-weight:700; font-size:0.95rem; padding:8px 0; border-top:2px solid #0b2b3c; margin-top:8px;">Итого работы: ${worksTotal} ₽</div>`;
        if (discountPercent > 0) {
            html += `<div style="text-align:right; font-size:0.9rem; color:#0a6030; padding:4px 0;">Скидка ${discountPercent}%: -${discountAmount.toFixed(2)} ₽</div>`;
            html += `<div style="text-align:right; font-weight:700; font-size:0.95rem; padding:4px 0; border-top:1px solid #d0dce8;">Итого работы со скидкой: ${worksTotalWithDiscount.toFixed(2)} ₽</div>`;
        }
    }
    html += `</div>`;

    html += `<div style="margin-top:16px; padding:14px; background:#f8fafc; border-radius:8px; border:2px solid #0b2b3c; text-align:center;">
        <div style="font-size:1.3rem; font-weight:700; color:#0b2b3c;">ОБЩАЯ СТОИМОСТЬ: ${grandTotal.toFixed(2)} ₽</div>
    </div>`;

    html += `<div style="margin-top:16px; padding-top:10px; border-top:2px solid #e4ecf4; display:flex; justify-content:flex-end; font-size:0.75rem; color:#3a657e;">
        <span>${new Date().toLocaleString()}</span>
    </div></div>`;
    container.innerHTML = html;
}

// ============================================================
// КЛИЕНТЫ
// ============================================================
function renderClients() {
    const tbody = document.getElementById('clientsBody');
    if (!tbody) return;
    tbody.innerHTML = '';
    const acceptedClients = clients.filter(c => c.is_new !== true);
    if (acceptedClients.length === 0) {
        tbody.innerHTML = `<tr><td colspan="9" style="text-align:center;padding:20px;color:#4a6f82;">Нет клиентов</td></tr>`;
        return;
    }
    acceptedClients.forEach((c, idx) => {
        const diagCount = journal.filter(e => e.type === 'diagnostic' && e.clientId === c.id).length;
        const repairCount = journal.filter(e => e.type === 'repair' && e.clientId === c.id).length;
        
        let codeDisplay = c.access_code || '—';
        let codeClass = 'client-badge';
        if (!c.access_code) {
            codeDisplay = '❌ Нет кода';
            codeClass = 'status-fail';
        }
        
        tbody.innerHTML += `<tr>
            <td>${idx+1}</td>
            <td><strong>${c.name}</strong></td>
            <td>${c.phone}</td>
            <td>${c.plate || '—'}</td>
            <td>${c.car || '—'}</td>
            <td><span class="${codeClass}">${codeDisplay}</span></td>
            <td>${diagCount}</td>
            <td>${repairCount}</td>
            <td>
                <button class="btn-sm" style="background:#0b2b3c;color:white;padding:4px 12px;border-radius:30px;border:none;cursor:pointer;" onclick="viewClientHistory(${c.id})"><i class="fas fa-history"></i></button>
                <button class="btn-sm" style="background:#d4a017;color:white;padding:4px 12px;border-radius:30px;border:none;cursor:pointer;" onclick="regenerateClientCode(${c.id})" title="Сгенерировать новый код"><i class="fas fa-key"></i></button>
                <button class="btn-danger" onclick="deleteClient(${c.id})"><i class="fas fa-trash"></i></button>
            </td>
        </tr>`;
    });
}

function addClientForm() {
    const name = prompt('Введите имя клиента:');
    if (!name || !name.trim()) return;
    const phone = prompt('Введите номер телефона:') || '';
    const plate = prompt('Введите гос. номер:') || '';
    const car = prompt('Введите марку автомобиля:') || '';
    
    const accessCode = String(Math.floor(1000 + Math.random() * 9000));
    
    const newClient = {
        id: clientIdCounter++,
        name: name.trim(),
        phone: phone.trim(),
        plate: plate.trim().toUpperCase(),
        car: car.trim(),
        access_code: accessCode,
        is_new: false
    };
    clients.push(newClient);
    renderClients();
    updateClientSelect();
    alert(`✅ Клиент добавлен!\n\n🔑 Код доступа: ${accessCode}\nСообщите его владельцу автомобиля.`);
    document.getElementById('clientsFeedback').innerHTML = `<i class="fas fa-check-circle" style="color:#2a8b5a;"></i> Клиент добавлен`;
    setTimeout(() => document.getElementById('clientsFeedback').innerHTML = '', 2000);
    autoSaveToLocalStorage();
}

function deleteClient(id) {
    if (!confirm('Удалить клиента?')) return;
    clients = clients.filter(c => c.id !== id);
    renderClients();
    updateClientSelect();
    autoSaveToLocalStorage();
}

function viewClientHistory(id) {
    const client = clients.find(c => c.id === id);
    if (!client) return;
    const clientEntries = journal.filter(e => e.clientId === id);
    if (clientEntries.length === 0) {
        alert(`У клиента ${client.name} нет записей`);
        return;
    }
    let msg = `📋 История клиента: ${client.name}\n\n`;
    clientEntries.forEach(e => {
        const type = e.type === 'diagnostic' ? '🔍 Диагностика' : '🔧 Ремонт';
        msg += `${type} — ${e.car} (${e.plate || '—'}) — ${e.date}\n`;
    });
    alert(msg);
}

function updateClientStats() {
    renderClients();
}

function updateClientSelect() {
    const select = document.getElementById('bk_client');
    if (!select) return;
    const currentValue = select.value;
    select.innerHTML = '<option value="">Выберите клиента...</option>';
    clients.forEach(c => {
        const option = document.createElement('option');
        option.value = c.id;
        option.textContent = `${c.name} (${c.phone || '—'})`;
        select.appendChild(option);
    });
    if (currentValue) select.value = currentValue;
}

function selectClientForBooking() {
    const select = document.getElementById('bk_client');
    const clientId = parseInt(select.value);
    if (!clientId) return;
    const client = clients.find(c => c.id === clientId);
    if (!client) return;
    document.getElementById('bk_name').value = client.name || '';
    document.getElementById('bk_phone').value = client.phone || '';
    document.getElementById('bk_car').value = client.car || '';
    document.getElementById('bk_plate').value = client.plate || '';
}

// ============================================================
// СИНХРОНИЗАЦИЯ КОДОВ ДОСТУПА
// ============================================================
window.syncClientCodes = async function() {
    const btn = document.querySelector('.btn-primary[onclick="syncClientCodes()"]');
    if (!btn) return;
    const originalText = btn.innerHTML;
    btn.disabled = true;
    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Синхронизация...';
    
    try {
        const jsonData = await loadJsonFromServer();
        if (!jsonData || !jsonData.clients) {
            alert('⚠️ На сервере нет клиентов для синхронизации');
            btn.disabled = false;
            btn.innerHTML = originalText;
            return;
        }
        
        let syncedCount = 0;
        for (const cloudClient of jsonData.clients) {
            const localClient = clients.find(c => 
                c.plate === cloudClient.plate && 
                c.name === cloudClient.name
            );
            
            if (localClient) {
                if (localClient.access_code !== cloudClient.access_code) {
                    localClient.access_code = cloudClient.access_code;
                    syncedCount++;
                }
            } else {
                clients.push({
                    id: clientIdCounter++,
                    name: cloudClient.name,
                    phone: cloudClient.phone || '',
                    plate: cloudClient.plate || '',
                    car: cloudClient.car || '',
                    access_code: cloudClient.access_code || String(Math.floor(1000 + Math.random() * 9000)),
                    is_new: false
                });
                syncedCount++;
            }
        }
        
        renderClients();
        updateClientSelect();
        autoSaveToLocalStorage();
        
        alert(`✅ Синхронизация кодов доступа завершена!\n\nОбновлено: ${syncedCount} клиентов`);
        
        document.getElementById('clientsFeedback').innerHTML = 
            `<i class="fas fa-check-circle" style="color:#2a8b5a;"></i> Синхронизация завершена! Обновлено: ${syncedCount} клиентов`;
        setTimeout(() => document.getElementById('clientsFeedback').innerHTML = '', 5000);
        
    } catch (error) {
        console.error('Ошибка синхронизации кодов:', error);
        alert('❌ Ошибка синхронизации кодов доступа: ' + error.message);
    }
    
    btn.disabled = false;
    btn.innerHTML = originalText;
};

// ============================================================
// РЕГЕНЕРАЦИЯ КОДА ДОСТУПА
// ============================================================
window.regenerateClientCode = async function(clientId) {
    if (!confirm('Сгенерировать новый код доступа для этого клиента?')) return;
    
    const client = clients.find(c => c.id === clientId);
    if (!client) {
        alert('Клиент не найден');
        return;
    }
    
    const newCode = String(Math.floor(1000 + Math.random() * 9000));
    const oldCode = client.access_code;
    
    try {
        client.access_code = newCode;
        
        const jsonData = await loadJsonFromServer();
        if (jsonData && jsonData.clients) {
            const cloudClient = jsonData.clients.find(c => 
                c.plate === client.plate && 
                c.name === client.name
            );
            if (cloudClient) {
                cloudClient.access_code = newCode;
                await saveJsonToServer(jsonData);
            }
        }
        
        renderClients();
        autoSaveToLocalStorage();
        
        alert(`✅ Код доступа обновлен!\n\nКлиент: ${client.name}\nСтарый код: ${oldCode || '—'}\nНовый код: ${newCode}\n\nСообщите новый код владельцу автомобиля.`);
        
        document.getElementById('clientsFeedback').innerHTML = 
            `<i class="fas fa-check-circle" style="color:#2a8b5a;"></i> Код обновлен для ${client.name}`;
        setTimeout(() => document.getElementById('clientsFeedback').innerHTML = '', 3000);
        
    } catch (error) {
        console.error('Ошибка обновления кода:', error);
        alert('❌ Ошибка обновления кода доступа: ' + error.message);
    }
};

// ============================================================
// ВОССТАНОВЛЕНИЕ СТАТИСТИКИ
// ============================================================
function restoreClientStats() {
    let restored = 0;
    journal.forEach(entry => {
        if (!entry.clientId) {
            const plate = entry.plate;
            const car = entry.car;
            let client = null;
            
            if (plate && plate !== 'не указан') {
                client = clients.find(c => c.plate === plate);
            }
            if (!client && car && car !== 'не указано') {
                client = clients.find(c => c.car === car || c.name === car);
            }
            if (client) {
                entry.clientId = client.id;
                restored++;
            }
        }
    });
    
    if (restored > 0) {
        autoSaveToLocalStorage();
        renderClients();
        renderJournal();
        alert(`✅ Восстановлено связей: ${restored}`);
    } else {
        alert('⚠️ Нет записей для восстановления');
    }
}

// ============================================================
// ЗАПИСИ
// ============================================================
function renderBookings() {
    const tbody = document.getElementById('bookingsBody');
    if (!tbody) return;
    
    const filter = document.getElementById('bookingsFilter').value;
    let filtered = bookings.filter(b => b.is_new !== true);
    
    filtered.sort((a, b) => {
        if (!a.date) return 1;
        if (!b.date) return -1;
        return new Date(b.date) - new Date(a.date);
    });
    
    if (filter === 'closed') {
        filtered = filtered.filter(b => CLOSED_STATUSES.includes(b.status));
    } else if (filter !== 'all') {
        filtered = filtered.filter(b => b.status === filter);
    }
    
    document.getElementById('bookingsTotal').textContent = bookings.filter(b => b.is_new !== true).length;
    tbody.innerHTML = '';
    
    if (filtered.length === 0) {
        tbody.innerHTML = `<tr><td colspan="12" style="text-align:center;padding:20px;color:#4a6f82;">Нет записей</td></tr>`;
        return;
    }
    
    filtered.forEach((b, idx) => {
        const isClosed = CLOSED_STATUSES.includes(b.status);
        const rowClass = isClosed ? 'inactive-row' : '';
        const disabled = isClosed ? 'disabled' : '';
        
        let linkHtml = '';
        if (b.linkedDiagId) {
            linkHtml = `<button class="btn-link" onclick="openLinkedDiag(${b.linkedDiagId})">🔍 Диагностика</button>`;
        } else if (b.linkedRepairId) {
            linkHtml = `<button class="btn-link" onclick="openLinkedRepair(${b.linkedRepairId})">🔧 Ремонт</button>`;
        } else {
            linkHtml = `
                <button class="btn-sm" style="background:#6c5b7b;color:white;padding:2px 6px;border-radius:15px;border:none;cursor:pointer;font-size:0.6rem;" onclick="manualLinkBookingToDiag(${b.id})">+ Диагн.</button>
                <button class="btn-sm" style="background:#6c5b7b;color:white;padding:2px 6px;border-radius:15px;border:none;cursor:pointer;font-size:0.6rem;" onclick="manualLinkBookingToRepair(${b.id})">+ Ремонт</button>
            `;
        }
        
        tbody.innerHTML += `<tr class="${rowClass}">
            <td>${idx+1}</td>
            <td><input type="text" value="${b.name}" ${disabled} onchange="updateBooking(${b.id},'name',this.value)"></td>
            <td><input type="text" value="${b.phone}" ${disabled} onchange="updateBooking(${b.id},'phone',this.value)"></td>
            <td><input type="text" value="${b.plate || ''}" ${disabled} onchange="updateBooking(${b.id},'plate',this.value)" style="text-transform:uppercase;font-weight:700;color:#0b2b3c;"></td>
            <td><input type="date" value="${b.date}" ${disabled} onchange="updateBooking(${b.id},'date',this.value)"></td>
            <td><input type="time" value="${b.time || ''}" ${disabled} onchange="updateBooking(${b.id},'time',this.value)"></td>
            <td><input type="text" value="${b.car}" ${disabled} onchange="updateBooking(${b.id},'car',this.value)"></td>
            <td>
                <select ${disabled} onchange="updateBooking(${b.id},'type',this.value)" style="width:100%;padding:4px 6px;border:1px solid #d0dce8;border-radius:6px;font-size:0.8rem;">
                    <option value="diagnostic" ${b.type==='diagnostic'?'selected':''}>Диагностика</option>
                    <option value="repair" ${b.type==='repair'?'selected':''}>Ремонт</option>
                </select>
            </td>
            <td>
                <select ${disabled} onchange="updateBooking(${b.id},'status',this.value)" class="status-select">
                    ${BOOKING_STATUSES.map(s => `<option value="${s}" ${b.status===s?'selected':''}>${s}</option>`).join('')}
                </select>
            </td>
            <td><input type="text" value="${b.reason||''}" ${disabled} onchange="updateBooking(${b.id},'reason',this.value)"></td>
            <td>${linkHtml}</td>
            <td>
                <button class="btn-copy" onclick="copyBooking(${b.id})" title="Копировать данные"><i class="fas fa-copy"></i></button>
                <button class="btn-insert" onclick="showBookingDetail(${b.id})" title="Подробно"><i class="fas fa-info-circle"></i></button>
                <button class="btn-danger" onclick="deleteBooking(${b.id})"><i class="fas fa-trash"></i></button>
            </td>
        </tr>`;
    });
}

function updateBooking(id, field, value) {
    const b = bookings.find(x => x.id === id);
    if (!b) return;
    if (CLOSED_STATUSES.includes(b.status) && field !== 'status') {
        alert('Эта запись закрыта и не может быть изменена');
        return;
    }
    b[field] = value;
    updateBookingsStorage();
    renderBookings();
    autoSaveToLocalStorage();
    
    if (field === 'status') {
        document.getElementById('bookingsFeedback').innerHTML = `<i class="fas fa-spinner fa-spin"></i> Сохранение статуса...`;
        updateBookingStatusInCloud(b.id, b.status)
            .then(() => {
                document.getElementById('bookingsFeedback').innerHTML = `<i class="fas fa-check-circle" style="color:#2a8b5a;"></i> Статус обновлен: ${b.status}`;
                setTimeout(() => document.getElementById('bookingsFeedback').innerHTML = '', 3000);
            })
            .catch((error) => {
                console.error('Ошибка обновления статуса:', error);
                document.getElementById('bookingsFeedback').innerHTML = `<i class="fas fa-exclamation-circle" style="color:#b33c3c;"></i> Ошибка обновления статуса`;
                setTimeout(() => document.getElementById('bookingsFeedback').innerHTML = '', 5000);
            });
    }
}

async function updateBookingStatusInCloud(bookingId, newStatus) {
    try {
        const jsonData = await loadJsonFromServer();
        if (!jsonData || !jsonData.bookings) {
            console.warn('Нет данных на сервере');
            return null;
        }
        
        const booking = jsonData.bookings.find(b => b.id === bookingId);
        if (booking) {
            booking.status = newStatus;
            const localBooking = bookings.find(b => b.id === bookingId);
            if (localBooking && localBooking.client_id) {
                booking.client_id = localBooking.client_id;
            }
        } else {
            const localBooking = bookings.find(b => b.id === bookingId);
            if (localBooking) {
                jsonData.bookings.push({
                    ...localBooking,
                    status: newStatus
                });
            }
        }
        
        await saveJsonToServer(jsonData);
        console.log('✅ Статус обновлен в JSON на сервере');
        return true;
        
    } catch (error) {
        console.error('❌ Ошибка обновления статуса:', error);
        throw error;
    }
}

function deleteBooking(id) {
    if (!confirm('Удалить запись?')) return;
    bookings = bookings.filter(b => b.id !== id);
    updateBookingsStorage();
    renderBookings();
    autoSaveToLocalStorage();
}

function copyBooking(id) {
    const b = bookings.find(x => x.id === id);
    if (!b) return;
    document.getElementById('bk_name').value = b.name || '';
    document.getElementById('bk_phone').value = b.phone || '';
    document.getElementById('bk_car').value = b.car || '';
    document.getElementById('bk_plate').value = b.plate || '';
    document.getElementById('bk_date').value = new Date().toISOString().slice(0,10);
    document.getElementById('bk_time').value = b.time || '';
    document.getElementById('bk_type').value = b.type || 'diagnostic';
    document.getElementById('bk_reason').value = b.reason || '';
    document.getElementById('bookingsFeedback').innerHTML = `<i class="fas fa-check-circle" style="color:#2a8b5a;"></i> Данные скопированы в форму.`;
    setTimeout(() => document.getElementById('bookingsFeedback').innerHTML = '', 3000);
}

function showBookingDetail(id) {
    const b = bookings.find(x => x.id === id);
    if (!b) return;
    currentBookingId = id;
    const modal = document.getElementById('bookingDetailModal');
    const content = document.getElementById('bookingDetailContent');
    const typeLabel = b.type === 'diagnostic' ? '🔍 Диагностика' : '🔧 Ремонт';
    content.innerHTML = `
        <div class="detail-row"><span class="label">Имя:</span><span class="value">${b.name || '—'}</span></div>
        <div class="detail-row"><span class="label">Телефон:</span><span class="value">${b.phone || '—'}</span></div>
        <div class="detail-row"><span class="label">Гос. номер:</span><span class="value">${b.plate || '—'}</span></div>
        <div class="detail-row"><span class="label">Марка:</span><span class="value">${b.car || '—'}</span></div>
        <div class="detail-row"><span class="label">Дата:</span><span class="value">${b.date || '—'}</span></div>
        <div class="detail-row"><span class="label">Время:</span><span class="value">${b.time || '—'}</span></div>
        <div class="detail-row"><span class="label">Тип:</span><span class="value">${typeLabel}</span></div>
        <div class="detail-row"><span class="label">Статус:</span><span class="value">${b.status || 'новая'}</span></div>
        <div class="detail-row"><span class="label">Причина:</span><span class="value">${b.reason || '—'}</span></div>
    `;
    modal.classList.add('active');
}

function closeBookingDetailModal() {
    document.getElementById('bookingDetailModal').classList.remove('active');
    currentBookingId = null;
}

function insertBookingToDiag() {
    const b = bookings.find(x => x.id === currentBookingId);
    if (!b) return;
    document.getElementById('carMake').value = b.car || '';
    document.getElementById('carPlate').value = b.plate || '';
    document.getElementById('carComplaints').value = b.reason || '';
    document.getElementById('diagDate').value = b.date || new Date().toISOString().slice(0,10);
    savedCarData = {
        make: b.car || '',
        plate: b.plate || '',
        year: document.getElementById('carYear').value || '----',
        mileage: document.getElementById('carMileage').value || '0',
        date: b.date || new Date().toISOString().slice(0,10),
        complaints: b.reason || ''
    };
    switchMode('diag');
    document.querySelectorAll('#page-diag .tabs .tab-btn').forEach(btn => btn.classList.remove('active'));
    document.querySelector('#page-diag .tabs .tab-btn[data-tab="diag1"]').classList.add('active');
    document.querySelectorAll('#page-diag .tab-content').forEach(tc => tc.classList.remove('active'));
    document.getElementById('diag1').classList.add('active');
    closeBookingDetailModal();
}

function insertBookingToRepair() {
    const b = bookings.find(x => x.id === currentBookingId);
    if (!b) return;
    document.getElementById('repairMake').value = b.car || '';
    document.getElementById('repairPlate').value = b.plate || '';
    document.getElementById('repairComplaints').value = b.reason || '';
    document.getElementById('repairDate').value = b.date || new Date().toISOString().slice(0,10);
    repairCarData = {
        make: b.car || '',
        plate: b.plate || '',
        year: document.getElementById('repairYear').value || '----',
        mileage: document.getElementById('repairMileage').value || '0',
        date: b.date || new Date().toISOString().slice(0,10),
        complaints: b.reason || '',
        discount: 'none'
    };
    switchMode('repair');
    document.querySelectorAll('#page-repair .tabs .tab-btn').forEach(btn => btn.classList.remove('active'));
    document.querySelector('#page-repair .tabs .tab-btn[data-tab="repair1"]').classList.add('active');
    document.querySelectorAll('#page-repair .tab-content').forEach(tc => tc.classList.remove('active'));
    document.getElementById('repair1').classList.add('active');
    closeBookingDetailModal();
}

function addBookingFromForm() {
    const name = document.getElementById('bk_name').value.trim();
    const phone = document.getElementById('bk_phone').value.trim();
    const car = document.getElementById('bk_car').value.trim();
    const plate = document.getElementById('bk_plate').value.trim().toUpperCase();
    const date = document.getElementById('bk_date').value;
    const time = document.getElementById('bk_time').value;
    const type = document.getElementById('bk_type').value;
    const reason = document.getElementById('bk_reason').value.trim();

    if (!name || !phone || !car || !date) {
        document.getElementById('bookingsFeedback').innerHTML = `<i class="fas fa-exclamation-circle" style="color:#b33c3c;"></i> Заполните имя, телефон, марку и дату!`;
        setTimeout(() => document.getElementById('bookingsFeedback').innerHTML = '', 3000);
        return;
    }

    let clientId = null;
    const existingClient = clients.find(c => 
        c.phone === phone || 
        (c.plate && c.plate === plate) ||
        (c.name === name && c.phone === phone)
    );
    
    if (existingClient) {
        clientId = existingClient.id;
    } else {
        const accessCode = String(Math.floor(1000 + Math.random() * 9000));
        const newClient = {
            id: clientIdCounter++,
            name: name,
            phone: phone,
            plate: plate || '',
            car: car,
            access_code: accessCode,
            is_new: false
        };
        clients.push(newClient);
        clientId = newClient.id;
        renderClients();
        updateClientSelect();
    }

    const newBooking = {
        id: bookingIdCounter++,
        name: name,
        phone: phone,
        date: date,
        time: time || '',
        car: car,
        plate: plate || '',
        type: type,
        status: 'новая',
        reason: reason || '',
        linkedDiagId: null,
        linkedRepairId: null,
        client_id: clientId,
        is_new: false
    };
    
    bookings.unshift(newBooking);
    updateBookingsStorage();
    renderBookings();
    document.getElementById('bk_name').value = '';
    document.getElementById('bk_phone').value = '';
    document.getElementById('bk_car').value = '';
    document.getElementById('bk_plate').value = '';
    document.getElementById('bk_date').value = new Date().toISOString().slice(0,10);
    document.getElementById('bk_time').value = '';
    document.getElementById('bk_reason').value = '';
    document.getElementById('bookingsFeedback').innerHTML = `<i class="fas fa-check-circle" style="color:#2a8b5a;"></i> Запись добавлена!`;
    setTimeout(() => document.getElementById('bookingsFeedback').innerHTML = '', 2000);
    autoSaveToLocalStorage();
}

function updateBookingsStorage() {
    try {
        localStorage.setItem('palych_bookings', JSON.stringify(bookings));
    } catch(e) {}
}

function manualLinkBookingToDiag(bookingId) {
    const diagEntries = journal.filter(e => e.type === 'diagnostic');
    if (diagEntries.length === 0) { alert('Нет сохранённых диагностик'); return; }
    let msg = 'Выберите диагностику для привязки:\n\n';
    diagEntries.forEach((e, i) => {
        msg += `${i+1}. ${e.car} (${e.plate || '—'}) — ${e.date}\n`;
    });
    msg += '\nВведите номер:';
    const choice = prompt(msg);
    if (choice && !isNaN(choice) && choice > 0 && choice <= diagEntries.length) {
        const b = bookings.find(x => x.id === bookingId);
        if (b) {
            b.linkedDiagId = diagEntries[choice-1].id;
            b.linkedRepairId = null;
            updateBookingsStorage();
            renderBookings();
            autoSaveToLocalStorage();
        }
    }
}

function manualLinkBookingToRepair(bookingId) {
    const repairEntries = journal.filter(e => e.type === 'repair');
    if (repairEntries.length === 0) { alert('Нет сохранённых ремонтов'); return; }
    let msg = 'Выберите ремонт для привязки:\n\n';
    repairEntries.forEach((e, i) => {
        msg += `${i+1}. ${e.car} (${e.plate || '—'}) — ${e.date}\n`;
    });
    msg += '\nВведите номер:';
    const choice = prompt(msg);
    if (choice && !isNaN(choice) && choice > 0 && choice <= repairEntries.length) {
        const b = bookings.find(x => x.id === bookingId);
        if (b) {
            b.linkedRepairId = repairEntries[choice-1].id;
            b.linkedDiagId = null;
            updateBookingsStorage();
            renderBookings();
            autoSaveToLocalStorage();
        }
    }
}

function openLinkedDiag(diagId) {
    const entry = journal.find(e => e.id === diagId);
    if (!entry) { alert('Диагностика не найдена'); return; }
    viewJournalEntry(diagId);
}

function openLinkedRepair(repairId) {
    const entry = journal.find(e => e.id === repairId);
    if (!entry) { alert('Ремонт не найден'); return; }
    viewJournalEntry(repairId);
}

// ============================================================
// ЖУРНАЛ
// ============================================================
function renderJournal() {
    const list = document.getElementById('journalList');
    const empty = document.getElementById('emptyJournal');
    if (!list) return;
    const filter = document.getElementById('journalFilter').value;
    const search = document.getElementById('journalSearch').value.toLowerCase().trim();
    let filtered = journal;
    if (filter !== 'all') {
        filtered = filtered.filter(e => e.type === filter);
    }
    if (search) {
        filtered = filtered.filter(e => 
            e.car.toLowerCase().includes(search) || 
            (e.plate && e.plate.toLowerCase().includes(search))
        );
    }
    document.getElementById('journalFilterCount').textContent = `Найдено: ${filtered.length}`;
    list.innerHTML = '';
    if (filtered.length === 0) {
        if (empty) empty.style.display = 'block';
        return;
    }
    if (empty) empty.style.display = 'none';
    filtered.slice().reverse().forEach(entry => {
        const div = document.createElement('div');
        div.className = 'journal-item';
        const typeLabel = entry.type === 'diagnostic' ? '🔍 Диагностика' : '🔧 Ремонт';
        const typeClass = entry.type === 'diagnostic' ? 'diag' : 'repair';
        div.innerHTML = `
            <div class="info">
                <span class="type ${typeClass}">${typeLabel}</span>
                <span class="car">${entry.car}</span>
                <span class="plate">${entry.plate || '—'}</span>
                <span class="date"><i class="far fa-calendar-alt"></i> ${entry.date}</span>
                <span style="font-size:0.75rem;color:#3a657e;">${entry.timestamp ? new Date(entry.timestamp).toLocaleString() : ''}</span>
            </div>
            <div class="actions">
                <button class="btn-sm" style="background:#0b2b3c;color:white;padding:4px 12px;border-radius:30px;border:none;cursor:pointer;" onclick="viewJournalEntry(${entry.id})"><i class="fas fa-eye"></i></button>
                <button class="btn-sm" style="background:#b33c3c;color:white;padding:4px 12px;border-radius:30px;border:none;cursor:pointer;" onclick="deleteJournalEntry(${entry.id})"><i class="fas fa-trash"></i></button>
            </div>
        `;
        list.appendChild(div);
    });
    updateFileStatus();
}

function viewJournalEntry(id) {
    const entry = journal.find(e => e.id === id);
    if (!entry) return;
    if (entry.type === 'diagnostic') {
        if (entry.tables) DIAG_TABLES = JSON.parse(JSON.stringify(entry.tables));
        if (entry.carData) savedCarData = JSON.parse(JSON.stringify(entry.carData));
        if (entry.systems) selectedSystems = new Set(entry.systems);
        renderSystemsGrid();
        updateDiagnosticsTab();
        updateReport();
        switchMode('diag');
        document.querySelectorAll('#page-diag .tabs .tab-btn').forEach(b => b.classList.remove('active'));
        document.querySelector('#page-diag .tabs .tab-btn[data-tab="diag4"]').classList.add('active');
        document.querySelectorAll('#page-diag .tab-content').forEach(tc => tc.classList.remove('active'));
        document.getElementById('diag4').classList.add('active');
        if (entry.carData) {
            document.getElementById('carMake').value = entry.carData.make || '';
            document.getElementById('carPlate').value = entry.carData.plate || '';
            document.getElementById('carYear').value = entry.carData.year || '';
            document.getElementById('carMileage').value = entry.carData.mileage || '';
            document.getElementById('carComplaints').value = entry.carData.complaints || '';
            if (entry.carData.date) document.getElementById('diagDate').value = entry.carData.date;
        }
    } else if (entry.type === 'repair') {
        if (entry.carData) repairCarData = JSON.parse(JSON.stringify(entry.carData));
        if (entry.parts) parts = JSON.parse(JSON.stringify(entry.parts));
        if (entry.works) works = JSON.parse(JSON.stringify(entry.works));
        parts.forEach(p => { if (p.id >= partIdCounter) partIdCounter = p.id + 1; });
        works.forEach(w => { if (w.id >= workIdCounter) workIdCounter = w.id + 1; });
        renderParts();
        renderWorks();
        updateAct();
        switchMode('repair');
        document.querySelectorAll('#page-repair .tabs .tab-btn').forEach(b => b.classList.remove('active'));
        document.querySelector('#page-repair .tabs .tab-btn[data-tab="repair4"]').classList.add('active');
        document.querySelectorAll('#page-repair .tab-content').forEach(tc => tc.classList.remove('active'));
        document.getElementById('repair4').classList.add('active');
        if (entry.carData) {
            document.getElementById('repairMake').value = entry.carData.make || '';
            document.getElementById('repairPlate').value = entry.carData.plate || '';
            document.getElementById('repairYear').value = entry.carData.year || '';
            document.getElementById('repairMileage').value = entry.carData.mileage || '';
            document.getElementById('repairComplaints').value = entry.carData.complaints || '';
            if (entry.carData.date) document.getElementById('repairDate').value = entry.carData.date;
            if (entry.carData.discount) document.getElementById('repairDiscount').value = entry.carData.discount;
        }
        renderDiscounts();
    }
}

function deleteJournalEntry(id) {
    if (confirm('Удалить запись?')) {
        journal = journal.filter(e => e.id !== id);
        renderJournal();
        updateFileStatus();
        autoSaveToLocalStorage();
    }
}

// ============================================================
// ПРАЙС-ЛИСТ
// ============================================================
function renderPrices() {
    const container = document.getElementById('pricesContainer');
    if (!container) return;
    const search = document.getElementById('priceSearch').value.toLowerCase().trim();
    let filtered = priceData;
    if (search) {
        filtered = filtered.filter(p => 
            p.service.toLowerCase().includes(search) || 
            p.category.toLowerCase().includes(search)
        );
    }
    if (filtered.length === 0) {
        container.innerHTML = `
            <div style="color:#4f6f82; background:#edf3fa; padding:30px; border-radius:16px; text-align:center;">
                <i class="fas fa-search" style="font-size:2rem; display:block; margin-bottom:8px;"></i>
                <p>${search ? 'Ничего не найдено по запросу "' + search + '"' : 'Нет услуг в прайс-листе'}</p>
            </div>
        `;
        return;
    }
    const categories = {};
    filtered.forEach(item => {
        if (!categories[item.category]) categories[item.category] = [];
        categories[item.category].push(item);
    });
    let html = `<div style="font-size:0.85rem; color:#3a657e; margin-bottom:8px;">Найдено услуг: <strong>${filtered.length}</strong></div>`;
    Object.keys(categories).forEach(cat => {
        html += `
            <div class="price-section">
                <div class="section-title" onclick="togglePriceSection(this)">
                    <span>${cat}</span>
                    <span><i class="fas fa-chevron-down"></i></span>
                </div>
                <div class="price-body">
                    <div class="price-row header">
                        <span>Услуга</span>
                        <span>Отечественные</span>
                        <span>Иномарки</span>
                        ${priceEditMode ? '<span>Действия</span>' : ''}
                    </div>
        `;
        categories[cat].forEach((item, idx) => {
            const domestic = item.domestic !== null ? item.domestic : '—';
            const importPrice = item.import !== null ? item.import : '—';
            const globalIdx = priceData.indexOf(item);
            html += `
                <div class="price-row">
                    <span class="service-name">${item.service}</span>
                    ${priceEditMode ? 
                        `<input type="text" value="${domestic}" onchange="updatePriceItem(${globalIdx},'domestic',this.value)" style="width:100%;padding:4px 6px;border:1px solid #d0dce8;border-radius:6px;font-size:0.8rem;">` :
                        `<span class="price-dom">${domestic} ₽</span>`
                    }
                    ${priceEditMode ? 
                        `<input type="text" value="${importPrice}" onchange="updatePriceItem(${globalIdx},'import',this.value)" style="width:100%;padding:4px 6px;border:1px solid #d0dce8;border-radius:6px;font-size:0.8rem;">` :
                        `<span class="price-import">${importPrice} ₽</span>`
                    }
                    ${priceEditMode ? 
                        `<span><button class="btn-danger" style="padding:2px 8px;font-size:0.6rem;" onclick="removePriceItem(${globalIdx})"><i class="fas fa-trash"></i></button></span>` :
                        ''
                    }
                </div>
            `;
        });
        html += `</div></div>`;
    });
    container.innerHTML = html;
}

function togglePriceSection(el) {
    const body = el.nextElementSibling;
    if (body.style.display === 'none') {
        body.style.display = 'block';
        el.querySelector('i').className = 'fas fa-chevron-down';
    } else {
        body.style.display = 'none';
        el.querySelector('i').className = 'fas fa-chevron-right';
    }
}

function editPriceMode() {
    priceEditMode = !priceEditMode;
    renderPrices();
    document.getElementById('priceFeedback').innerHTML = priceEditMode ? 
        `<i class="fas fa-info-circle" style="color:#f6b83d;"></i> Режим редактирования включён.` :
        `<i class="fas fa-check-circle" style="color:#2a8b5a;"></i> Режим редактирования выключен.`;
    setTimeout(() => document.getElementById('priceFeedback').innerHTML = '', 3000);
}

function updatePriceItem(idx, field, value) {
    if (priceData[idx]) {
        priceData[idx][field] = value;
        autoSaveToLocalStorage();
    }
}

function removePriceItem(idx) {
    if (!confirm('Удалить позицию из прайс-листа?')) return;
    priceData.splice(idx, 1);
    renderPrices();
    autoSaveToLocalStorage();
}

function addPriceItem() {
    const category = prompt('Введите категорию:') || 'Другое';
    const service = prompt('Введите название услуги:');
    if (!service) return;
    const domestic = prompt('Введите цену для отечественных (или "от X"):') || '0';
    const importPrice = prompt('Введите цену для иномарок (или "от X"):') || '0';
    priceData.push({ category: category, service: service, domestic: domestic, import: importPrice });
    renderPrices();
    autoSaveToLocalStorage();
}

// ============================================================
// ЭТАЛОНЫ
// ============================================================
function loadEtalons() {
    try {
        const saved = localStorage.getItem('palych_etalons');
        if (saved) {
            etalonData = JSON.parse(saved);
            if (Object.keys(etalonData).length === 0) {
                initEtalonsFromDiag();
            }
        } else {
            initEtalonsFromDiag();
        }
    } catch(e) {
        console.warn('Ошибка загрузки эталонов:', e);
        initEtalonsFromDiag();
    }
    renderEtalons();
}

function initEtalonsFromDiag() {
    if (etalonData && Object.keys(etalonData).length > 0) return;
    etalonData = {};
    SYSTEMS.forEach(sys => {
        const tableData = DIAG_TABLES[sys.id] || [];
        if (tableData.length > 0) {
            etalonData[sys.id] = {};
            tableData.forEach(row => {
                if (row.param) {
                    etalonData[sys.id][row.param] = {
                        norm: row.norm || '',
                        note: row.note || ''
                    };
                }
            });
        }
    });
    saveEtalons();
}

function saveEtalons() {
    try {
        localStorage.setItem('palych_etalons', JSON.stringify(etalonData));
    } catch(e) {
        console.warn('Ошибка сохранения эталонов:', e);
    }
}

function renderEtalons() {
    const container = document.getElementById('etalonsContainer');
    if (!container) return;
    if (!etalonData || Object.keys(etalonData).length === 0) {
        loadEtalons();
        return;
    }
    const search = document.getElementById('etalonSearch').value.toLowerCase().trim();
    let hasData = false;
    let filteredSystems = {};
    Object.keys(etalonData).forEach(sysId => {
        const sys = SYSTEMS.find(s => s.id === sysId);
        const sysName = sys ? sys.name.toLowerCase() : sysId;
        const params = etalonData[sysId] || {};
        const filteredParams = {};
        Object.keys(params).forEach(param => {
            if (!search || sysName.includes(search) || param.toLowerCase().includes(search)) {
                filteredParams[param] = params[param];
                hasData = true;
            }
        });
        if (Object.keys(filteredParams).length > 0) {
            filteredSystems[sysId] = filteredParams;
        }
    });
    if (!hasData) {
        container.innerHTML = `
            <div style="color:#4f6f82; background:#edf3fa; padding:30px; border-radius:16px; text-align:center;">
                <i class="fas fa-database" style="font-size:2rem; display:block; margin-bottom:8px;"></i>
                <p>${search ? 'Ничего не найдено по запросу "' + search + '"' : 'Нет эталонных значений'}</p>
                <button class="btn-primary" style="margin-top:12px;" onclick="initEtalonsFromDiag()">
                    <i class="fas fa-sync"></i> Инициализировать из диагностики
                </button>
            </div>
        `;
        return;
    }
    let html = `<div style="margin-bottom:12px; display:flex; gap:8px; flex-wrap:wrap; align-items:center;">
        <span style="font-size:0.85rem; color:#3a657e;">Найдено систем: <strong>${Object.keys(filteredSystems).length}</strong></span>
        <button class="btn-sm btn-success" onclick="initEtalonsFromDiag()" style="margin-left:auto;"><i class="fas fa-sync"></i> Обновить</button>
    </div>`;
    SYSTEMS.forEach(sys => {
        const params = filteredSystems[sys.id] || {};
        const paramNames = Object.keys(params);
        if (paramNames.length === 0) return;
        html += `
            <div style="margin-top:14px; border:1px solid #e4ecf4; border-radius:8px; overflow:hidden;">
                <div style="background:#0b2b3c; color:white; padding:8px 14px; font-weight:700; display:flex; justify-content:space-between; align-items:center;">
                    <span>🔧 ${sys.name}</span>
                    <span style="font-size:0.75rem; font-weight:400; opacity:0.8;">${paramNames.length} параметров</span>
                </div>
                <div style="padding:6px 0;">
                    <div style="display:grid; grid-template-columns:2fr 1.2fr 1fr 0.5fr; padding:6px 12px; background:#eef3f8; font-weight:700; font-size:0.75rem; color:#1f4055; border-bottom:2px solid #d0dce8;">
                        <span>Параметр</span>
                        <span>Норма</span>
                        <span>Примечание</span>
                        <span style="text-align:center;">Действия</span>
                    </div>`;
        paramNames.forEach(param => {
            const etalon = params[param];
            html += `
                <div style="display:grid; grid-template-columns:2fr 1.2fr 1fr 0.5fr; padding:6px 12px; border-bottom:1px solid #eef2f7; font-size:0.85rem; align-items:center; gap:4px;">
                    <span style="font-weight:600;color:#0b2b3c;">${param}</span>
                    <span>
                        <input type="text" id="etalon_norm_${sys.id}_${param.replace(/\s/g,'_')}" value="${etalon.norm || ''}" 
                               style="width:100%; padding:4px 6px; border:1px solid #d0dce8; border-radius:6px; font-size:0.8rem;"
                               onchange="updateEtalon('${sys.id}','${param.replace(/'/g,"\\'")}','norm',this.value)">
                    </span>
                    <span>
                        <input type="text" id="etalon_note_${sys.id}_${param.replace(/\s/g,'_')}" value="${etalon.note || ''}" 
                               style="width:100%; padding:4px 6px; border:1px solid #d0dce8; border-radius:6px; font-size:0.8rem;"
                               onchange="updateEtalon('${sys.id}','${param.replace(/'/g,"\\'")}','note',this.value)">
                    </span>
                    <span style="text-align:center;">
                        <button class="btn-danger" style="padding:2px 8px; font-size:0.65rem;" onclick="removeEtalonParam('${sys.id}','${param.replace(/'/g,"\\'")}')">
                            <i class="fas fa-trash"></i>
                        </button>
                    </span>
                </div>`;
        });
        html += `
            <div style="padding:6px 12px; background:#fafcff; display:flex; gap:8px; align-items:center; flex-wrap:wrap;">
                <input type="text" id="new_param_${sys.id}" placeholder="Название параметра" style="flex:1; min-width:120px; padding:4px 8px; border:1px solid #d0dce8; border-radius:6px; font-size:0.8rem;">
                <button class="btn-sm btn-success" onclick="addEtalonParam('${sys.id}')"><i class="fas fa-plus"></i> Добавить</button>
            </div>
        `;
        html += `</div></div>`;
    });
    container.innerHTML = html;
}

function updateEtalon(sysId, param, field, value) {
    if (!etalonData[sysId]) etalonData[sysId] = {};
    if (!etalonData[sysId][param]) etalonData[sysId][param] = { norm: '', note: '' };
    etalonData[sysId][param][field] = value;
    saveEtalons();
    autoSaveToLocalStorage();
}

function addEtalonParam(sysId) {
    const input = document.getElementById(`new_param_${sysId}`);
    const paramName = input.value.trim();
    if (!paramName) {
        document.getElementById('etalonsFeedback').innerHTML = `<i class="fas fa-exclamation-circle" style="color:#b33c3c;"></i> Введите название параметра`;
        setTimeout(() => document.getElementById('etalonsFeedback').innerHTML = '', 2000);
        return;
    }
    if (!etalonData[sysId]) etalonData[sysId] = {};
    if (etalonData[sysId][paramName]) {
        document.getElementById('etalonsFeedback').innerHTML = `<i class="fas fa-exclamation-circle" style="color:#b33c3c;"></i> Параметр уже существует`;
        setTimeout(() => document.getElementById('etalonsFeedback').innerHTML = '', 2000);
        return;
    }
    etalonData[sysId][paramName] = { norm: '', note: '' };
    saveEtalons();
    renderEtalons();
    input.value = '';
    autoSaveToLocalStorage();
}

function removeEtalonParam(sysId, param) {
    if (!confirm(`Удалить параметр "${param}" из эталонов?`)) return;
    if (etalonData[sysId]) {
        delete etalonData[sysId][param];
        if (Object.keys(etalonData[sysId]).length === 0) {
            delete etalonData[sysId];
        }
        saveEtalons();
        renderEtalons();
        autoSaveToLocalStorage();
    }
}

// ============================================================
// НАСТРОЙКИ
// ============================================================
function renderSettings() {
    const container = document.getElementById('settingsContainer');
    if (!container) return;
    let html = '';
    SYSTEMS.forEach((sys) => {
        const params = PARAMS[sys.id] || [];
        html += `
            <div class="settings-group">
                <div class="flex-between">
                    <h4>${sys.name}</h4>
                    <div>
                        <button class="btn-warning" onclick="editSystem('${sys.id}')"><i class="fas fa-edit"></i></button>
                        <button class="btn-danger" onclick="removeSystem('${sys.id}')"><i class="fas fa-trash"></i></button>
                    </div>
                </div>
                <div class="settings-item">
                    <span class="param-name">Описание:</span>
                    <input type="text" id="desc_${sys.id}" value="${sys.desc}" style="flex:1;">
                </div>
                <div class="settings-item" style="flex-wrap:wrap; gap:4px;">
                    <span class="param-name">Параметры:</span>
                    <div class="settings-param-list" id="params_${sys.id}">
                        ${params.map((p, pi) => `
                            <span class="param-tag">
                                ${p}
                                <span class="remove" onclick="removeParam('${sys.id}', ${pi})">×</span>
                            </span>
                        `).join('')}
                    </div>
                    <button class="btn-sm btn-success" onclick="addParam('${sys.id}')" style="padding:2px 10px;">+</button>
                </div>
            </div>
        `;
    });
    container.innerHTML = html;
}

function editSystem(sysId) {
    const sys = SYSTEMS.find(s => s.id === sysId);
    if (!sys) return;
    const newName = prompt('Новое название системы:', sys.name);
    if (newName && newName.trim()) {
        sys.name = newName.trim();
        const descInput = document.getElementById('desc_' + sysId);
        if (descInput) sys.desc = descInput.value;
        renderSettings();
        renderSystemsGrid();
        updateDiagnosticsTab();
        updateReport();
        autoSaveToLocalStorage();
    }
}

function removeSystem(sysId) {
    if (!confirm('Удалить систему "' + SYSTEMS.find(s => s.id === sysId)?.name + '" и все её данные?')) return;
    SYSTEMS = SYSTEMS.filter(s => s.id !== sysId);
    delete PARAMS[sysId];
    delete DIAG_TABLES[sysId];
    selectedSystems.delete(sysId);
    renderSettings();
    renderSystemsGrid();
    updateDiagnosticsTab();
    updateReport();
    autoSaveToLocalStorage();
}

function addParam(sysId) {
    const newParam = prompt('Введите название нового параметра:');
    if (newParam && newParam.trim()) {
        if (!PARAMS[sysId]) PARAMS[sysId] = [];
        PARAMS[sysId].push(newParam.trim());
        if (DIAG_TABLES[sysId]) {
            DIAG_TABLES[sysId].push({
                param: newParam.trim(),
                value: '',
                status: 'unknown',
                checked: false,
                note: ''
            });
        }
        renderSettings();
        renderSystemsGrid();
        updateDiagnosticsTab();
        updateReport();
        autoSaveToLocalStorage();
    }
}

function removeParam(sysId, idx) {
    if (!PARAMS[sysId]) return;
    if (!confirm('Удалить параметр "' + PARAMS[sysId][idx] + '"?')) return;
    PARAMS[sysId].splice(idx, 1);
    if (DIAG_TABLES[sysId]) {
        DIAG_TABLES[sysId].splice(idx, 1);
    }
    renderSettings();
    renderSystemsGrid();
    updateDiagnosticsTab();
    updateReport();
    autoSaveToLocalStorage();
}

function addNewSystem() {
    const name = prompt('Введите название новой системы:');
    if (!name || !name.trim()) return;
    const desc = prompt('Введите описание системы:') || '';
    const id = 'custom_' + systemIdCounter++;
    SYSTEMS.push({ id: id, name: name.trim(), desc: desc });
    PARAMS[id] = ['Параметр 1', 'Параметр 2', 'Параметр 3'];
    DIAG_TABLES[id] = PARAMS[id].map(p => ({
        param: p,
        value: '',
        status: 'unknown',
        checked: false,
        note: ''
    }));
    renderSettings();
    renderSystemsGrid();
    updateDiagnosticsTab();
    updateReport();
    autoSaveToLocalStorage();
}

function saveSettings() {
    SYSTEMS.forEach(sys => {
        const descInput = document.getElementById('desc_' + sys.id);
        if (descInput) sys.desc = descInput.value;
    });
    renderSettings();
    renderSystemsGrid();
    updateDiagnosticsTab();
    updateReport();
    autoSaveToLocalStorage();
}

// ============================================================
// СКИДКИ
// ============================================================
function renderDiscounts() {
    const container = document.getElementById('discountsList');
    if (!container) return;
    container.innerHTML = '';
    if (discounts.length === 0) {
        container.innerHTML = '<div style="padding:6px 12px; color:#4a6f82;">Нет скидок</div>';
        return;
    }
    discounts.forEach(d => {
        container.innerHTML += `
            <div class="settings-item" style="border-bottom:1px solid #eef2f7;">
                <span class="param-name">${d.name}</span>
                <span style="min-width:80px; font-weight:700; color:#0b2b3c;">${d.percent}%</span>
                <span style="min-width:80px;">
                    <button class="btn-danger" style="padding:2px 10px; font-size:0.7rem;" onclick="removeDiscount(${d.id})"><i class="fas fa-trash"></i></button>
                </span>
            </div>
        `;
    });
    const discountSelect = document.getElementById('repairDiscount');
    if (discountSelect) {
        const currentVal = discountSelect.value;
        discountSelect.innerHTML = '<option value="none">Без скидки</option>';
        discounts.forEach(d => {
            const opt = document.createElement('option');
            opt.value = d.id;
            opt.textContent = `${d.name} (${d.percent}%)`;
            discountSelect.appendChild(opt);
        });
        if (currentVal) discountSelect.value = currentVal;
    }
}

function addDiscount() {
    const name = document.getElementById('newDiscountName').value.trim();
    const percent = parseInt(document.getElementById('newDiscountPercent').value);
    if (!name) {
        document.getElementById('settingsFeedback').innerHTML = `<i class="fas fa-exclamation-circle" style="color:#b33c3c;"></i> Введите название скидки`;
        setTimeout(() => document.getElementById('settingsFeedback').innerHTML = '', 2000);
        return;
    }
    if (isNaN(percent) || percent <= 0 || percent > 100) {
        document.getElementById('settingsFeedback').innerHTML = `<i class="fas fa-exclamation-circle" style="color:#b33c3c;"></i> Введите корректный процент (1-100)`;
        setTimeout(() => document.getElementById('settingsFeedback').innerHTML = '', 2000);
        return;
    }
    discounts.push({ id: discountIdCounter++, name: name, percent: percent });
    document.getElementById('newDiscountName').value = '';
    document.getElementById('newDiscountPercent').value = '';
    renderDiscounts();
    autoSaveToLocalStorage();
}

function removeDiscount(id) {
    if (!confirm('Удалить скидку?')) return;
    discounts = discounts.filter(d => d.id !== id);
    renderDiscounts();
    autoSaveToLocalStorage();
}

// ============================================================
// ОНЛАЙН ЗАЯВКИ
// ============================================================
async function loadNewRequests() {
    try {
        const jsonData = await loadJsonFromServer();
        
        if (!jsonData || !jsonData.bookings) {
            document.getElementById('newRequestsContainer').innerHTML = `
                <div style="color:#3a657e; font-size:0.85rem; text-align:center; padding:20px;">
                    <i class="fas fa-inbox" style="font-size:1.5rem; display:block; margin-bottom:6px;"></i>
                    Нет новых заявок
                </div>
            `;
            return;
        }
        
        newRequests = jsonData.bookings.filter(b => b.is_new === true);
        
        if (jsonData.clients) {
            newClients = jsonData.clients.filter(c => c.is_new === true);
        } else {
            newClients = [];
        }
        
        renderNewRequests();
        
    } catch (error) {
        console.error('Ошибка загрузки заявок:', error);
        document.getElementById('newRequestsContainer').innerHTML = `
            <div style="color:#b33c3c; font-size:0.85rem; text-align:center; padding:20px;">
                ❌ Ошибка загрузки: ${error.message}
            </div>
        `;
    }
}

function renderNewRequests() {
    const container = document.getElementById('newRequestsContainer');
    const countEl = document.getElementById('newRequestsCount');
    const total = newRequests.length + newClients.length;
    
    if (countEl) countEl.textContent = total;
    
    if (total === 0) {
        container.innerHTML = `
            <div style="color:#3a657e; font-size:0.85rem; text-align:center; padding:20px;">
                <i class="fas fa-inbox" style="font-size:1.5rem; display:block; margin-bottom:6px;"></i>
                Нет новых заявок
            </div>
        `;
        return;
    }
    
    let html = '';
    
    newClients.forEach(c => {
        html += `
            <div class="request-item client-item">
                <div>
                    <span class="name">👤 ${c.name}</span>
                    <span class="plate">${c.plate}</span>
                    <span class="car">${c.car}</span>
                    <span class="badge-new badge-client">Новый клиент</span>
                </div>
                <button class="btn-sm btn-success" onclick="acceptNewClient(${c.id})" style="padding:4px 12px;">
                    <i class="fas fa-check"></i> Принять
                </button>
            </div>
        `;
    });
    
    newRequests.forEach(b => {
        html += `
            <div class="request-item">
                <div>
                    <span class="name">📋 ${b.name}</span>
                    <span class="plate">${b.plate}</span>
                    <span class="car">${b.car}</span>
                    <span class="badge-new badge-booking">${b.type === 'diagnostic' ? 'Диагностика' : 'Ремонт'}</span>
                </div>
                <button class="btn-sm btn-success" onclick="acceptNewBooking(${b.id})" style="padding:4px 12px;">
                    <i class="fas fa-check"></i> Принять
                </button>
            </div>
        `;
    });
    
    container.innerHTML = html;
}

async function acceptNewClient(clientId) {
    if (!confirm('Принять нового клиента в базу?')) return;
    
    try {
        const jsonData = await loadJsonFromServer();
        if (!jsonData) {
            showNotification('❌ Ошибка загрузки данных с сервера', 'error');
            return;
        }
        
        const client = jsonData.clients.find(c => c.id === clientId);
        if (client) {
            client.is_new = false;
            
            const exists = clients.some(c => c.id === clientId);
            if (!exists) {
                clients.push({
                    ...client,
                    access_code: client.access_code || String(Math.floor(1000 + Math.random() * 9000))
                });
            }
        }
        
        await saveJsonToServer(jsonData);
        
        renderClients();
        updateClientSelect();
        await loadNewRequests();
        
        showNotification('✅ Клиент принят в базу!', 'success');
    } catch (error) {
        console.error('Ошибка принятия клиента:', error);
        showNotification('❌ Ошибка принятия клиента: ' + error.message, 'error');
    }
}

async function acceptNewBooking(bookingId) {
    if (!confirm('Принять заявку и перенести в раздел "Записи"?')) return;
    
    try {
        const jsonData = await loadJsonFromServer();
        if (!jsonData) {
            showNotification('❌ Ошибка загрузки данных с сервера', 'error');
            return;
        }
        
        const booking = jsonData.bookings.find(b => b.id === bookingId);
        if (booking) {
            booking.is_new = false;
            
            const exists = bookings.some(b => b.id === bookingId);
            if (!exists) {
                bookings.push({
                    ...booking,
                    linkedDiagId: null,
                    linkedRepairId: null
                });
            }
        }
        
        await saveJsonToServer(jsonData);
        
        renderBookings();
        updateBookingsStorage();
        autoSaveToLocalStorage();
        await loadNewRequests();
        
        showNotification('✅ Заявка перенесена в раздел "Записи"!', 'success');
    } catch (error) {
        console.error('Ошибка принятия заявки:', error);
        showNotification('❌ Ошибка принятия заявки: ' + error.message, 'error');
    }
}

// ============================================================
// УВЕДОМЛЕНИЯ
// ============================================================
function showNotification(message, type = 'info') {
    const existing = document.querySelector('.notification-main');
    if (existing) existing.remove();
    
    const div = document.createElement('div');
    div.className = `notification-main ${type}`;
    div.textContent = message;
    document.body.appendChild(div);
    
    setTimeout(() => {
        div.style.opacity = '0';
        div.style.transition = 'opacity 0.5s';
        setTimeout(() => div.remove(), 500);
    }, 4000);
}

// ============================================================
// ИНИЦИАЛИЗАЦИЯ
// ============================================================
document.addEventListener('DOMContentLoaded', function() {
    const today = new Date().toISOString().slice(0,10);
    document.getElementById('diagDate').value = today;
    document.getElementById('repairDate').value = today;
    document.getElementById('bk_date').value = today;
    
    loadFromLocalStorage();
    
    try {
        const saved = localStorage.getItem('palych_bookings');
        if (saved) bookings = JSON.parse(saved);
    } catch(e) {}
    if (bookings.length > 0) {
        bookingIdCounter = Math.max(...bookings.map(b => b.id || 0)) + 1;
    }
    
    renderAll();
    document.getElementById('cloudStatus').innerHTML = '<span class="sync-status sync-ok">☁️ Облако готово</span>';
    
    setInterval(autoSaveToLocalStorage, 30000);
    setInterval(loadNewRequests, 30000);
});

document.querySelectorAll('#page-diag .tabs .tab-btn').forEach(btn => {
    btn.addEventListener('click', function() {
        const parent = this.closest('.tabs');
        parent.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
        this.classList.add('active');
        const tabId = this.dataset.tab;
        const content = document.getElementById('page-diag');
        content.querySelectorAll('.tab-content').forEach(tc => tc.classList.remove('active'));
        content.querySelector('#' + tabId).classList.add('active');
    });
});

document.querySelectorAll('#page-repair .tabs .tab-btn').forEach(btn => {
    btn.addEventListener('click', function() {
        const parent = this.closest('.tabs');
        parent.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
        this.classList.add('active');
        const tabId = this.dataset.tab;
        const content = document.getElementById('page-repair');
        content.querySelectorAll('.tab-content').forEach(tc => tc.classList.remove('active'));
        content.querySelector('#' + tabId).classList.add('active');
        if (tabId === 'repair4') updateAct();
    });
});

console.log('🚀 PalЫCH Car Diagnost v4.6 загружен!');
</script>
</body>
</html>
