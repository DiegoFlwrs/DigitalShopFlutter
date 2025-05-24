import 'package:flutter/material.dart';

class Faqpag extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {
      "question": "¿Cómo puedo hacer un pedido?",
      "answer":
          "Solo debes navegar por el catálogo, elegir tus productos y presionar 'Agregar al carrito'. Luego finalizas tu pedido desde la sección del carrito."
    },
    {
      "question": "¿Cuáles son los métodos de pago disponibles?",
      "answer":
          "Aceptamos pagos por Yape, Plin, transferencia bancaria y pagos contra entrega en zonas específicas de Trujillo."
    },
    {
      "question": "¿Hacen envíos fuera de Trujillo?",
      "answer":
          "Sí, realizamos envíos a todo el Perú a través de empresas de courier. Los costos varían según el destino."
    },
    {
      "question": "¿Puedo cambiar o devolver un producto?",
      "answer":
          "Sí, tienes hasta 7 días para solicitar cambios. El producto debe estar en buen estado y sin uso. Consulta nuestras políticas de devolución."
    },
    {
      "question": "¿Dónde puedo ver el seguimiento de mi pedido?",
      "answer":
          "Recibirás un código de seguimiento una vez que tu pedido sea enviado. También puedes consultar desde tu cuenta en la app."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAD6C7),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 138, 101, 90),
        elevation: 2,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.support_agent, size: 24),
            SizedBox(width: 8),
            Text(
              'Preguntas Frecuentes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '¿Tienes dudas?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Aquí respondemos las más comunes para ayudarte al instante.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            ...faqs.map(
              (faq) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 3,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    title: Text(
                      faq["question"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.brown,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        child: Text(
                          faq["answer"]!,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // acción de contacto
                },
                icon: const Icon(Icons.support_agent),
                label: const Text("¿Aún necesitas ayuda? Contáctanos"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5D4037),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}