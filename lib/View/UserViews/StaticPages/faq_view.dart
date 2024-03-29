import 'package:falcanli/Globals/Widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class FaqView extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<FaqView> {
  bool isAllSelect = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Sıkça Sorulan Sorular"),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            EntryItem(data[index]),
        itemCount: data.length,
      ),
    );
  }

  RichText info() {
    return RichText(
      text: const TextSpan(
        style: TextStyle(color: Colors.black),
        children: <TextSpan>[
          TextSpan(
              text: 'Para Nedir?\n',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          TextSpan(
              text:
                  '   İlk para niteliğinde kullanılan madde neydi diye düşündünüz mü hiç ? Nakit paranın ilk hali deniz kabuğuydu! Hatta bu birim bazı Afrika bölgelerinde 20. Yüzyıla kadar kullanılmaya devam etmiştir.\n \n',
              style: TextStyle(fontSize: 15)),
          TextSpan(
              text:
                  '   Para, mal ve hizmetlerin değiş tokuşu için kullanılan araçlardan en yaygın olanı. Para sözcüğü ile genellikle madeni para ve banknotlar kastedilmekle birlikte; ekonomide, vadesiz mevduatlar ve kredi kartları da para meydana getiren unsurlardan sayılır. Vadeli mevduat, devlet tahvili gibi değişim araçları ise para benzeri olarak nitelendirilir.\n \n',
              style: TextStyle(fontSize: 15)),
          TextSpan(
              text: 'Neden Para Biriktirmeliyiz?\n',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          TextSpan(
              text:
                  '   Para biriktirmek, birçok kişiye oldukça sıkıcı, cimrilik göstergesi ve gereksiz gelebilir. Bunun yanında çocukluğumuzda para ile ilgili öğrendiğimiz ilk şey de, biriktirmektir. Paramızı bilinçli bir şekilde harcamamız, savurgan olmamamız, ihtiyaçlarımızı karşılamak için bir kenarda birikmiş paramızın olması gerektiği, milyonlarca kere söylenmiş olabilir. Ama çocukken verilen bu öğütler, bir hikaye misali unutulup gider.\n\n',
              style: TextStyle(fontSize: 15)),
          TextSpan(
              text:
                  '   Para biriktirmenin önemini, ilerleyen yaşlarda unuttuğumuz zaman ve bir maaş sahibi olduğumuz zaman işler biraz karışabilir. Düşüncesizce yapılan harcamalar sonrasında ayın sonunun getirilememesi, ev geçindirmede çekilen sıkıntılar, her geçen gün artan kredi ve kredi kartı borçları ile boğuşur dururuz. İşte bunlarla karşılaşmamak için öncelikle para yönetimi konusunda duyarlı olmamız gerekiyor. Unutmayın ki; tasarruf, bütçeleme, birikim ve yatırım gibi konulara ilginizin olması, direkt olarak finansal durumunuzu iyileştirmektedir.\n\n',
              style: TextStyle(fontSize: 15)),
          TextSpan(
              text:
                  '   Parasal sıkıntısı olanlar veya gelecek mali durumu konusunda endişe duyanlar için para biriktirmek oldukça önemlidir. Belli bir birikiminizin olması ise hayallerinize birkaç adım daha yakın olmanızı sağlar. İşte “neden para biriktirmeliyim” diyenler için ikna edici sebepler sizlerle…\n\n',
              style: TextStyle(fontSize: 15)),
          TextSpan(
              text:
                  '  1- Daha iyi hissetmek \n  2-Eğlenceli bir emeklilik \n  3- Çocuğunuz için eğiitim fonu \n  4- Daha çok paraya sahip olmak\n  5- Daha büyük bir ev satın almak \n  6- Daha rahat bir hayat \n  7- Daha bağımsız yaşamak \n  8- Daha az stresli olmak\n  9- Statü sahibi olmak \n  10- Gereksiz harcamaları önlemede kolaylık\n  11- En önemlisi ise hayallerini gerçekleştirmek\n\n',
              style: TextStyle(fontSize: 15)),
          TextSpan(
              text: 'Nasıl Para Biriktiririz?\n',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          TextSpan(
              text:
                  '   Bu soruya yanıt vermeden önce birkaç temel kavramı öğrenmemiz gerekiyor.\n\n',
              style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
          TextSpan(
              text: '  1- Bütçe:\n',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          TextSpan(
              text:
                  '     Bütçe yapılmayan hedefler domino taşı etkisine benzer. Önemsemediğimiz ufak bir finansal hata gelecekteki tüm taşların yıkılmasına sebep olabilir. Sağlam durmak istiyorsak hedeflerimiz için Bütçe yapmalıyız. Unutma bugün için küçümsediğin bütçen gelecekte çok daha büyük olabilir. Bugün kazandığın bir davranış tüm geleceğine kazandırabilir ya da kaybettirebilir. Bu durumdan dolayı gelirimiz ne kadar az olursa olsun bütçe yapmalıyız.\n\n',
              style: TextStyle(fontSize: 15)),
          TextSpan(
              text: 'Unutmamak gerekir ki doğru formül \n\n',
              style: TextStyle(fontSize: 15)),
          TextSpan(
            text: 'GELİR-HARCAMALAR=BİRİKİM ',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'değil\n',
            style: TextStyle(fontSize: 15),
          ),
          TextSpan(
            text: 'GELİR-BİRİKİM=HARCAMALAR',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: "'dır.\n\n",
            style: TextStyle(fontSize: 15),
          ),
          TextSpan(
            text:
                "Dünya çapında en çok tavsiye edilen bütçe planı ise gelirimizin %50’si Zorunlu Harcamalar(gıda, ulaşım, barınma gibi) %30 Keyfi harcamalar (eğlence, sinema, tatil gibi) %20’si ise finansal önceliklerdir(Emeklilik, birikimler, yatırımlar gibi)\n\n",
            style: TextStyle(fontSize: 15),
          ),
          TextSpan(
            text: "Peki Parasal Hatalar Neden Yapılır?\n\n",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text:
                "  1- Harcama yaparken rasyonel davranmamak\n  2- Ekonomik kararlarda psikojinin etkisi\n  3- Plansızlık\n  4-Kendimize hak görmek\n  5- Gelirinden fazla harcamak \n\n",
            style: TextStyle(fontSize: 15),
          ),
          TextSpan(
            text: "  2- Acil Durum Fonu\n",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text:
                "Acil Durum Fonu biriktirmeliyiz! O ne mi? Acil durumlara karşı bir kenarda size maliyeti olmayan birikiminizin hesabınız. Yani beklenmedik olaylar karşısında güçlü olmanızı sağlayan nakit para. Bu para en az giderlerinizin 3 katı miktarında olmalı. Acil Durum Fonu’nun 4 önemli şartı var:\n\n",
            style: TextStyle(fontSize: 15),
          ),
          TextSpan(
            text: "  • Bu para nakit olmalı,\n",
            style: TextStyle(fontSize: 15),
          ),
          TextSpan(
            text: "  • Kolay erişelebilir olmalı,\n",
            style: TextStyle(fontSize: 15),
          ),
          TextSpan(
            text: "  • Ayrı bir hesapta olmalı,\n",
            style: TextStyle(fontSize: 15),
          ),
          TextSpan(
            text: "  • Maliyeti olmamalı,\n",
            style: TextStyle(fontSize: 15),
          ),
          TextSpan(
            text: "Yani acil durum fonu bir yatırım aracında durmamalıdır.\n\n",
            style: TextStyle(fontSize: 15),
          ),
          TextSpan(
            text: "  3- Borçlar\n",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text:
                "Aşağıda yer alan soruları borçlanmadan önce kendimize sorduğumuz vakit doğru sonuca ulaşacağınıza güvenim tam :)\n",
            style: TextStyle(fontSize: 15),
          ),
          TextSpan(
            text: "  • Düzenli bir gelirim var mı? Ne kadar?\n",
            style: TextStyle(fontSize: 15),
          ),
          TextSpan(
            text: "  • Tahmini giderlerim ne kadar?\n",
            style: TextStyle(fontSize: 15),
          ),
          TextSpan(
            text:
                "  • Borcum, ödeme gücümü aşarsa karşılık gösterecek varlıklarım neler?\n",
            style: TextStyle(fontSize: 15),
          ),
          TextSpan(
            text: "  • Birikimklerim ne kadar?\n",
            style: TextStyle(fontSize: 15),
          ),
          TextSpan(
            text: "  • Daha önce borç alıp ödedim mi? Nasıl bir deneyimdi?\n",
            style: TextStyle(fontSize: 15),
          ),
          TextSpan(
            text: "  4- Yatırımlar\n\n",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text:
                "  Yatırım tasarruflarımızı enflasyona karşı korumak içindir.\n  Yatırım kazanç fırsatlarını değerlendirmek içindir.\n\n",
            style: TextStyle(fontSize: 15),
          ),
          TextSpan(
            text: "  Yatırım Çeşitleri:\n\n",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text:
                "    a- Mali yatırımlar\n    b- Hisse senedi\n    c- Tahvil\n    d- Banka Yatırımları\n    e- Döviz\n    f- Emlak yatırımları gibi sıralanabilir.\n\n",
            style: TextStyle(fontSize: 15),
          ),
          TextSpan(
            text:
                "Öğrenmemiz gereken her şeyi öğrendiğimize göre artık para biriktirmeyi öğrenebiliriz.\n\n",
            style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
          ),
          TextSpan(
            text: "  1- Bilinçli Bir Şekilde Para Biriktirmek\n\n",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text:
                "    a- Önce kendine ödeme yap\n    b- Yeni borca girmekten kaçın\n    c-Makul tasarruf hedefleri belirle\n    d-Bütçene uygun yaşa\n    e- Hedeflerin için bir zaman aralığı belirle\n    f- Harcamalarını kayıt altına al\n    g- Ödediğin tüm meblağları iki kere kontrol et\n    h- Mümkün olduğunca kısa sürede tasarruf etmeye başla\n    i- Bir emeklilik hesabına ödeme yapmayı düşün\n    j- Borsa yatırımını dikkatle yap.\n    k- Umudunu kaybetme!\n\n",
            style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
          ),
          TextSpan(
            text: "  2- Harcamaları Kısıtlamak\n\n",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text:
                "    a- Lüks tüketimi bütçenden çıkar\n    b- Daha ucuz bir daire bul\n    c- Daha ucuza yemek ye\n    d-Elektrik kullanımını azalt\n    e- ucuz ulaşım yöntemleri kullan\n    f- Daha ucuza(ya da ücretsiz) eğlen\n    g- Pahalı bağımlılıklardan kaçın\n\n",
            style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
          ),
          TextSpan(
            text: "  3- Parayı Akıllıca Harcamak\n\n",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text:
                "    a- Parayı ilk olarak temel ihtiyaçlara harca\n    b- Bir acil durum fonu ayır\n    c- Borçlarını öde\n    d- Sonra kenara para koy\n    e- Temel olmayan ihtiyaçlara akıllıca para Harca\n    f- Lüks harcamaları sona bırak\n\n\n\n\n\n",
            style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  tabBar() {
    return Container(
      height: 36,
      width: MediaQuery.of(context).size.width - 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 5.0,
            spreadRadius: 1,
            offset: const Offset(0.0, 1),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                isAllSelect = true;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              height: 48,
              width: (MediaQuery.of(context).size.width - 48) / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: isAllSelect ? Colors.green : Colors.white,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "S.S.S.",
                  style: TextStyle(
                    fontSize: 12,
                    color: isAllSelect ? Colors.white : const Color(0xFF5D6A78),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                isAllSelect = false;
              });
            },
            child: AnimatedContainer(
              curve: Curves.decelerate,
              duration: const Duration(milliseconds: 150),
              height: 48,
              width: (MediaQuery.of(context).size.width - 48) / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: !isAllSelect ? Colors.green : Colors.white,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Bilgilendirme",
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        !isAllSelect ? Colors.white : const Color(0xFF5D6A78),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.as, [this.children = const <Entry>[]]);
  // ignore: non_constant_identifier_names
  final Text as;
  //final String title;
  final List<Entry> children;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry(
    const Text(
      'Neden Kumbara+ uygulamasını kullanmalıyım?',
      style: TextStyle(color: Colors.white),
    ),
    <Entry>[
      Entry(
        const Text('Aslında hiç bir neden yok, gereksiz bir uygulama. '),
      )
    ],
  ),
  Entry(
    const Text('Paramı uygulama hesabında mı saklamam gerek?'),
    <Entry>[
      Entry(
        const Text(
            'Hayır, Kumbara+ sadece verilerinizi görselleştiren bir uygulamadır.'),
      )
    ],
  ),
  Entry(
    const Text('Yeni özellikler eklenecek mi?'),
    <Entry>[
      Entry(
        const Text(
            'Ishkembe Studios olarak sabit kalmayı sevmeyen bir organizasyonuz ve geliştirmeye çok açık olan bu uygulamamızın yeni versiyonları yakın vakitte çıkacaktır. Sizin bu uygulama için fikriniz var ise yorumlarda bunu belirtip geliştirmeye katkıda bulunabilirsiniz.'),
      )
    ],
  ),
  Entry(
    const Text('Ishkembe Studios Nedir?'),
    <Entry>[
      Entry(
        const Text(
            "'CBU TECH' adlı Teknoloji şirketinin Start-Up projesi olan Ishkembe Studios, bir grup istekli ve yetenekli genç tarafından yönetilmektedir. Kar amacı gütmeyen bu kuruluş hayatı kolaylaştırmaya ve güzelleştirmeye yönelik çalışmalar yürütmektedir."),
      )
    ],
  ),
  Entry(
    const Text('Size nasıl ulaşırım?'),
    <Entry>[
      Entry(
        const Text(
            'ishkembeStudios@gmail.com adlı mail adresinden ulaşabilirsiniz.'),
      )
    ],
  ),
  Entry(
    const Text("Kumbara+'ı kimler kullanabilir?"),
    <Entry>[
      Entry(
        const Text(
            'Herhangi bir kısıtlama yoktur, basit ve kullanışlı arayüzü sayesinde dileyen herkes kullanabilir.'),
      )
    ],
  ),
  Entry(
    const Text("v1.3 için planlarınız neler?"),
    <Entry>[
      Entry(
        const Text(
            'Öncelikler bir sonraki v1.3 güncellemesinden önce ara güncellemeler ve geliştirmeler geleceğiniz belirtmek isteriz. v1.3 versiyonunda ise uygulama gerçek paralarla çalışıp paranızı mastercard ve visa güvencesi altında uygulama içerisinde saklayabileceksiniz ayrıyetten bir sürü sürpriz yenilik sizi bekliyor olacak :)'),
      )
    ],
  ),
  Entry(
    const Text("Neden bir kumbara uygulaması için kayıt olmam gerekiyor?"),
    <Entry>[
      Entry(
        const Text(
            'Her ne kadar kontrolünü sağlamaktan çekinsekte sizin ne kadar iyi veya kötü birikimci olup olmadığınızı topluluk ile karşılaştırıp kendinize motivasyon sağlamanız için'),
      )
    ],
  ),
  Entry(
    const Text(
        "Bundan sonraki projeler için Ishkembe Studios'a destek olmak istiyorum, ne yapabilirim?"),
    <Entry>[
      Entry(
        const Text(
            'IshkembeStudios@gmail.com adresine mail atarak geliştirici ekibimize katılabilirsin!'),
      ),
    ],
  ),
];

class EntryItem extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const EntryItem(this.entry);

  final Entry entry;
  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return ListTile(
          title: Text(
        root.as.data.toString(),
        style: const TextStyle(color: Colors.black54),
      ));
    }
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(
        root.as.data.toString(),
        style: const TextStyle(color: Colors.black),
      ),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
