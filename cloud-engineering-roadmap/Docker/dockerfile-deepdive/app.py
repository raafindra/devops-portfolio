from http.server import SimpleHTTPRequestHandler, HTTPServer
import os

PORT = int(os.environ.get("APP_PORT", 8080))

class Handler(SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.end_headers()
        self.wfile.write(b"Production Container is Running Securely as Non-Root!\n")

    def log_message(self, format, *args):
        # Structured log format untuk monitoring
        print(f"[CONTAINER_LOG] - {self.address_string()} - {format%args}")

if __name__ == "__main__":
    server = HTTPServer(("0.0.0.0", PORT), Handler)
    print(f"Starting server on port {PORT}...")
    server.serve_forever()