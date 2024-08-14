import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          "تواصل معنا",
          style: TextStyle(fontFamily: "Schyler"),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              child: IconButton(
                icon: const Icon(
                  Icons.phone,
                  color: Colors.blue,
                ),
                onPressed: () {
                  // رقم الهاتف
                  // ignore: deprecated_member_use
                  launch('tel:+966571025752');
                },
              ),
            ),
            InkWell(
              child: const CircleAvatar(
                backgroundImage: AssetImage("assets/youtube_4494485.png"),
              ),
              onTap: () {
                // رابط الواتساب
                // ignore: deprecated_member_use
                launch(
                    'https://www.youtube.com/channel/UCcpZ386oh4ugUQZSUNc3muA/videos');
              },
            ),
            InkWell(
              child: const CircleAvatar(
                backgroundImage: AssetImage("assets/whatsapp_4494495.png"),
              ),
              onTap: () {
                // رابط الواتساب
                // ignore: deprecated_member_use
                launch('https://wa.me/+966571025752');
              },
            ),
            CircleAvatar(
              child: IconButton(
                icon: const Icon(
                  Icons.email,
                  color: Colors.blue,
                ),
                onPressed: () {
                  // رابط البريد الإلكتروني
                  // ignore: deprecated_member_use
                  launch('info@sso-ksa.com');
                },
              ),
            ),
            CircleAvatar(
              child: IconButton(
                icon: const Icon(
                  Icons.shopping_cart_rounded,
                  color: Colors.blue,
                ),
                onPressed: () {
                  // رابط البريد الإلكتروني
                  // ignore: deprecated_member_use
                  launch('https://ss-offers.com');
                },
              ),
            ),
            CircleAvatar(
              child: IconButton(
                icon: const Icon(
                  Icons.location_on,
                  color: Colors.blue,
                ),
                onPressed: () {
                  // رابط البريد الإلكتروني
                  // ignore: deprecated_member_use
                  launch("https://maps.app.goo.gl/qGPvUr5nzpxej8d27");
                },
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

class ContactSection1 extends StatelessWidget {
  const ContactSection1({super.key});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Divider(),
            const SizedBox(
              height: 5,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "تواصل معنا ",
                  style: TextStyle(fontFamily: "Schyler"),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                // ignore: deprecated_member_use
                launch('tel:+966571025752');
              },
              child: const Row(children: [
                CircleAvatar(
                  child: Icon(
                    Icons.phone,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "tel:+966571025752",
                  style: TextStyle(fontFamily: "Schyler"),
                )
              ]),
            ),
            const SizedBox(
              height: 5,
            ),
            InkWell(
              child: const Row(children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/youtube_4494485.png"),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'https://www.youtube.com/channel/UCcpZ386oh',
                  style: TextStyle(fontFamily: "Schyler"),
                )
              ]),
              onTap: () {
                // رابط الواتساب
                // ignore: deprecated_member_use
                launch(
                    'https://www.youtube.com/channel/UCcpZ386oh4ugUQZSUNc3muA/videos');
              },
            ),
            const SizedBox(
              height: 5,
            ),
            InkWell(
              child: const Row(children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/whatsapp_4494495.png"),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'https://wa.me/+966571025752',
                  style: TextStyle(fontFamily: "Schyler"),
                )
              ]),
              onTap: () {
                // رابط الواتساب
                // ignore: deprecated_member_use
                launch('https://wa.me/+966571025752');
              },
            ),
            const SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                // ignore: deprecated_member_use
                launch('info@sso-ksa.com');
              },
              child: const Row(children: [
                CircleAvatar(
                  child: Icon(
                    Icons.email,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'info@sso-ksa.com',
                  style: TextStyle(fontFamily: "Schyler"),
                )
              ]),
            ),
            const SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                // رابط البريد الإلكتروني
                // ignore: deprecated_member_use
                launch('https://ss-offers.com');
              },
              child: const Row(children: [
                CircleAvatar(
                  child: Icon(
                    Icons.shopping_cart_rounded,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'https://ss-offers.com',
                  style: TextStyle(fontFamily: "Schyler"),
                )
              ]),
            ),
            const SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                // ignore: deprecated_member_use
                launch("https://maps.app.goo.gl/qGPvUr5nzpxej8d27");
              },
              child: const Row(children: [
                CircleAvatar(
                  child: Icon(
                    Icons.location_on,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "https://maps.app.goo.gl/qGPvUr5nzpxej8d27",
                  style: TextStyle(fontFamily: "Schyler"),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
