import tornado.ioloop
import tornado.web


class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.write("Hello, world")


class FileHandler(tornado.web.RequestHandler):
    def post(self, filename):
        body = bytes.decode(self.request.body)
        if body == "":
            self.set_status(400)
            self.finish("Sem valores no post da mensagem")
        file_save = open(filename + ".txt", "w")
        file_save.write(body)
        file_save.close()

    def get(self, filename):
        try:
            file_read = open(filename + ".txt", "r")
            self.write((file_read.read()))
            file_read.close()
        except IOError as e:
            self.set_status(404)
            self.finish("Arquivo não existe")
        except:
            self.finish("Erro no processamento do arquivo")
            raise


def make_app():
    return tornado.web.Application([
        (r"/", MainHandler),
        (r"/content/(\w+)", FileHandler),
    ])


if __name__ == "__main__":
    app = make_app()
    app.listen(8888)
    tornado.ioloop.IOLoop.current().start()
