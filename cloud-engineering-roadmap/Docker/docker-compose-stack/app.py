from http.server import SimpleHTTPRequestHandler, HTTPServer
import os
import urllib.request
import json
import socket

PORT = int(os.environ.get("APP_PORT", 8080))
ENVIRONMENT = os.environ.get("APP_ENV", "development")
REDIS_HOST = os.environ.get("REDIS_HOST", "redis")

# Sederhana: Simulasi koneksi socket ke Redis untuk increment counter
def get_hit_count():
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.settimeout(2.0)
        s.connect((REDIS_HOST, 6379))
        s.sendall(b"*2\r\n$4\r\nINCR\r\n$4\r\nhits\r\n")
        response = s.recv(1024).decode("utf-8", errors="ignore")
        s.close()
        # Parse output Redis simple integer response: ":<number>\r\n"
        if response.startswith(":"):
            return response.strip().lstrip(":")
        return "1"
    except Exception as e:
        return f"Error connecting to Redis: {str(e)}"

class Handler(SimpleHTTPRequestHandler):
    def do_GET(self):
        hits = get_hit_count()
        response_body = (
            f"--- Multi-Container Stack (Docker Compose) ---\n"
            f"Environment : {ENVIRONMENT}\n"
            f"Connected to: {REDIS_HOST}:6379\n"
            f"Page Views  : {hits}\n"
        )
        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.end_headers()
        self.wfile.write(response_body.encode("utf-8"))

    def log_message(self, format, *args):
        print(f"[COMPOSE_LOG] - {self.address_string()} - {format%args}")

if __name__ == "__main__":
    server = HTTPServer(("0.0.0.0", PORT), Handler)
    print(f"Server started on port {PORT} in {ENVIRONMENT} mode...")
    server.serve_forever()