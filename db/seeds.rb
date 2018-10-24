ADMIN_EMAIL = 'admin@peatio.dev'
ADMIN_PASSWORD = 'Pass@word8'

begin

admin_identity = Identity.find_or_create_by(email: ADMIN_EMAIL)
admin_identity.password = admin_identity.password_confirmation = ADMIN_PASSWORD
admin_identity.is_active = true
admin_identity.save!

puts "ssssssssssssssssssssss"

admin_member = Member.find_or_create_by(email: ADMIN_EMAIL)
admin_member.authentications.build(provider: 'identity', uid: admin_identity.id)
unless admin_member.valid?
  #puts admin_member.errors.inspect
end
admin_member.save!

puts "000000000000000000"

if Rails.env == 'development'
  NORMAL_PASSWORD = 'Pass@word8'

  foo = Identity.create(email: 'foo@peatio.dev', password: NORMAL_PASSWORD, password_confirmation: NORMAL_PASSWORD, is_active: true)
  foo_member = Member.create(email: foo.email)
  foo_member.authentications.build(provider: 'identity', uid: foo.id)
  foo_member.tag_list.add 'vip'
  foo_member.tag_list.add 'hero'
  foo_member.save

  puts "111111111111111111"

  bar = Identity.create(email: 'bar@peatio.dev', password: NORMAL_PASSWORD, password_confirmation: NORMAL_PASSWORD, is_active: true)
  bar_member = Member.create(email: bar.email)
  bar_member.authentications.build(provider: 'identity', uid: bar.id)
  bar_member.tag_list.add 'vip'
  bar_member.tag_list.add 'hero'
  bar_member.save
  puts "22222222222222222222222"
end


puts "3333333333333333333"

rescue
end
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#User.destroy_all
user1 = Member.create(username: 'userBob', password: 'iambob', email: 'bobisgreat@gmail.com')
puts user1.errors.inspect
user2 = Member.create(username: 'Betty Smith', password: 'iambetty', email: 'bettyIsGreat@gmail.com')
user3 = Member.create(username: 'April Jones', password: 'iamapril', email: 'aprilIsGreat@gmail.com')
user4 = Member.create(username: 'Sam Dekker ', password: 'iamsam', email: 'samIsGreat@gmail.com')
user5 = Member.create(username: 'Luis Baez', password: 'iamluis', email: 'luisIsGreat@gmail.com')

category1 = Category.create(
  name: 'Arts'
)
puts "4444444444444444444444"

category2 = Category.create(
  name: 'Comics'
)

category3 = Category.create(
  name: 'Design'
)

category4 = Category.create(
  name: 'Film'
)

category5 = Category.create(
  name: 'Food'
)

category6 = Category.create(
  name: 'Games'
)

category7 = Category.create(
  name: 'Music'
)

category8 = Category.create(
  name: 'Publishing'
)

category9 = Category.create(
  name: 'Fashion'
)

#Project.destroy_all


project1 = Project.create(author: user1.username, category_id: category1.id ,user_id: user1.id, title: 'QUARTZ Bottle - Water Purification in a Self-Cleaning Bottle:', blurb:'No more stinky water bottles', description: 'The QUARTZ bottle is a reusable, rechargeable, insulated water bottle that cleans itself and the water you put inside it. With digital purification from UVC light, your water and bottle is purified at the touch of a button.
 ', end_date: '10/24/2018', funding_goal: 30000, image_url: 'https://ksr-ugc.imgix.net/assets/018/810/436/390339e6110be68d81dde21b6b92c5ed_original.png?crop=faces&w=560&h=315&fit=crop&v=1510445617&auto=format&q=92&s=dcd42884d334729731a35805d5820b6e', total_amount: 0)

project2 = Project.create(author: user2.username, category_id: category5.id, user_id: user2.id, title: 'Greater Goods - Heirloom-Quality Cast Iron for Everyone', blurb:'We’ve created affordable heirloom-quality cast iron by using a modern manufacturing process to replicate heritage craftsmanship.', description: 'Cast iron used to be priced for everyone to afford—like the skillet that’s been in our family since the 1930’s, which originally cost $2. To get a pan like that today, you have to spend $100 or more. Together with the rest of our team at Greater Goods, we set out to make a 10” skillet that’s better than anything out there, at a price that is accessible to anyone. ', end_date: '9/12/2019', funding_goal: 12000, image_url: 'https://ksr-ugc.imgix.net/assets/018/946/698/2fd66ae5de1e2204828b20632198a5c6_original.jpg?w=680&fit=max&v=1509123268&auto=format&q=92&s=a6abfce2083af41d73a7718d9b27009c', total_amount: 0)


project3 = Project.create(author: user3.username, category_id: category2.id, user_id: user3.id, title: 'Stand Still Stay Silent - Book 2
', blurb:'Help us print the second book of Minna Sundberg\'s award-winning Nordic fantasy and adventure webcomic Stand Still. Stay Silent.', description: 'Hunters, mages and cleansers dedicate their lives to defending these settlements from the terrifying beings from beyond the safe areas, creatures from the Silent World. Before now, there has been no official attempts to explore the Silent World.', end_date: '12/31/2019', funding_goal: 35000, image_url: 'https://ksr-ugc.imgix.net/assets/018/727/690/046d2b2672ddfa75ab5a87c53cd197b2_original.jpg?w=680&fit=max&v=1507842937&auto=format&q=92&s=82ccf4f7e75e9d84558e77928d111712', total_amount: 0)


project4 = Project.create(author: user4.username, category_id: category6.id, user_id: user4.id, title:'Dunpets Colors - Dungeon Crawl & Pets', blurb:'Create your team of monsters to explore endless dungeons, solve puzzles, infiltrate evil lairs and protect the Dunpet World!', description: 'Dunpets Colors is the new fusion of Dungeon Crawl and monster breeding by GuGames Development. A classic gaming experience adapted to the modern lifestyle!', end_date: '11/23/2020', funding_goal: 100000, image_url: 'https://ksr-ugc.imgix.net/assets/019/271/132/2d7fa46d17abf87cc7487f20b09b46d0_original.gif?w=680&fit=max&v=1510909879&auto=format&gif-q=50&q=92&s=43d727dd28aa0066409b6228ba4f019d', total_amount: 0)

project5 = Project.create(author: user1.username, category_id: category6.id, user_id: user1.id, title: 'Nimbatus - The Space Drone Constructor', blurb: 'Nimbatus is a procedurally generated action simulation game. Build space drones out of countless parts and explore a huge galaxy.', description: 'After countless hours of construction work, our team has built up a ship. The Nimbatus can’t wait to start its engines and burst off into the vastness of space and into adventure.
But what is a ship without a crew? Join our crew and get ready for an exciting journey!

Nimbatus is a space-game in which you build physically simulated drones out of hundreds of different parts and solve missions in a huge procedurally generated universe filled with fully destructible planets and vicious enemies. In an online mode you compare your creations with other players from all around the world and compete in a wide array of diverse challenges.', end_date: '12/31/17', funding_goal: 50000, image_url: 'https://ksr-ugc.imgix.net/assets/018/896/054/3f14f228f0972000146c43c676c64af1_original.gif?w=680&fit=max&v=1508858934&auto=format&gif-q=50&q=92&s=6b5dc89c3c6a32c9be86e731ef01fc19', total_amount: 0)

project6 = Project.create(author: user2.username, category_id: category1.id, user_id: user2.id, title: 'Visiting: Creighton Baxter Artist Residency at CASTLEDRONE', blurb: 'Visiting is a CASTLEDRONE artist residency supporting the development, documentation & exhibition of new work by Creighton Baxter.', description: 'Visiting is a paid residency opportunity for LA-based artist Creighton Baxter at CASTLEDRONE, a studio and gallery space in Boston. While in residence, Baxter will create a new series of public performances and drawings, collect photo and video documentation of her work and host studio visits with regional curators. Four of Baxter’s performances will be open to the public and the resulting drawings and documentation will be compiled for an East-Coast exhibition in Spring 2018. We are fundraising in order to offer Baxter a stipend for her time and offset the costs associated with the development of this new work.', end_date: '12/31/17', funding_goal: 50000, total_amount: 0,
  image_url: 'https://ksr-ugc.imgix.net/assets/019/442/824/ff129f35e7772f8621daf15492bb04d3_original.jpg?w=680&fit=max&v=1512056425&auto=format&q=92&s=d9721e4f3751f67105e181911ca5e02f')

project7 = Project.create(author: user3.username, category_id: category1.id, user_id: user3.id, title: 'he his own mythical beast', blurb: 'A performance meditation on the mythologies of identity, race, neutrality and the black body in postmodern culture premiering Jan 2018', description: 'This is where it all started, with this question, and I created Venus, named after the Hottentot Venus, aka Sarah Baartman, an enslaved black woman who was exhibited as an exotic in the early 19th Century London and Paris. Venus is a character that flirts with black face, gender ambiguity and sexuality, coupled with the incongruities of dominance, vulnerability, erasure and visibility. I sought to understand how something exotic could be normalized or neutralized within a performance setting.

This question led to the development of a series of investigations and performance installations related to the complexities of identity and perception: The Sessions (Gibney, 2013), Venus Redux (The Invisible Dog, 2014), The Venus Knot (The Invisible Dog, 2015) Chimaera (BRIC & The Bronx Museum, 2016), and The Voyeurs (Brooklyn Bridge Park & Madison Square Park, 2016). Each iteration was a different exploration of form and content.', end_date: '12/31/17', funding_goal: 50000, image_url: 'https://ksr-ugc.imgix.net/assets/019/416/781/c507c22f8acc9a48ceb9d556812d85b2_original.png?w=680&fit=max&v=1511901477&auto=format&lossless=true&s=5731aeaca4ad2a4385273cbf9be9c2fc', total_amount: 0)

project8 = Project.create(author: user4.username, category_id: category7.id, user_id: user4.id, title: 'Our Next CD – Once More With Feeling!', blurb: 'We have an amazing crop of new songs we think youre gonna like an we are almost finished recording. Help us launch CD Number 5!', description: 'It’s hard to believe but it’s been almost five years since our last record. We want to thank everyone who helped us out on – All Our Luck Is Changing. Since then, we’ve been working hard on a batch of new songs that we’re really excited about. And last summer, we began working on this new record. We’re very happy to have Laurie Lewis producing. Laurie is a legend in the Folk and Bluegrass community, and its been really fun to work with her and some other great musicians on this recording.', end_date: '12/31/17', funding_goal: 50000,
  image_url: 'https://ksr-ugc.imgix.net/assets/019/339/244/eb32af4bf88d238ebbf115da74741ffa_original.jpeg?w=680&fit=max&v=1511332091&auto=format&q=92&s=739bd4784b2b4e5f3aa7bc28143fdf05', total_amount: 0)

project9 = Project.create(author: user4.username, category_id: category2.id, user_id: user4.id, title: 'Gone - An Sci-Fi Mystery Graphic Novel + Backer Commissions', blurb: 'On a deserted spacecraft, the AssistA powers up, and begins its search for survivors, unaware it might not be as alone as it thinks...', description: 'Gone is our popular sci-fi mystery comic, about the AssistA robot, who wakes on board a vessel that should be home to thousands of crew, but is, in fact, desolate. Confused and alone, the AssistA sets off to find out where everyone has gone to. Along the way he starts receiving interference in the forms of memories from one of the crew members, from before everyone disappeared.', end_date: '12/31/17', funding_goal: 50000, image_url: 'https://ksr-ugc.imgix.net/assets/019/274/838/d29fd9aa879afa612318d4000d4c298d_original.jpg?w=680&fit=max&v=1510931734&auto=format&q=92&s=28225a0ee2e24194d7e574f0eaf2af37', total_amount: 0)

project10 = Project.create(author: user1.username, category_id: category5, user_id: user1.id, title: 'Mexico Creates: Pato Negro, Cerámica Contemporánea', blurb: 'Ayúdame a adquirir un horno y retomar la producción de mis vasitos japoneses Kuroi Ahiru, para crecer producción de Pato Negro.', description: 'El concepto de mi marca esta inspirado en la historia del Patito Feo, donde un patito que por ser distinto a los demás era rechazado, pero cuando descubren que en realidad se trataba de un cisne, ese rechazo se convierte en admiración. En mi opinión, muchas veces pasa lo mismo con los objetos artesanales. Cuando los comparamos con objetos producidos en masa, tendemos a preferir la estética perfecta del producto industrial. Sin embargo creo que cuando conocemos lo que esconden los objetos artesanales, nuestra opinión cambia como en el cuento y descubrimos también su verdadera belleza.

Hace siete años, viví unos meses en Japón. Ahí aprendí lo básico del proceso cerámico y elaboré mi pieza más preciada, los vasos cerveceros Kuroi Ahiru. Desde entonces he ido experimentando y aprendiendo poco a poco a formular los materiales, explorar las paletas de colores, mejorar los acabados, y aunque sigo aprendiendo desde mi estudio en Chihuahua México, creo que por fin he encontrado el balance entre lo que planeo y lo que realmente sale del horno, así que ¡estoy lista para crecer mi negocio!  ', end_date: '12/31/17', funding_goal: 50000, image_url: 'https://ksr-ugc.imgix.net/assets/019/412/069/42bd888ce8e90f19ca291f7830b3e68b_original.jpg?w=680&fit=max&v=1511882204&auto=format&q=92&s=4b37e2c41255e42845a987f5ea207c08', total_amount: 0)


project13 = Project.create(author: user2.username, category_id: category1.id ,user_id: user2.id, title: 'Young Space Contemporary Art Website and Gallery', blurb:'Young Space is getting a redesigned visual identity, a new website, and finally starting a physical space!', description: 'orem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam vel odio vitae felis pretium efficitur a sagittis ligula. Aliquam vestibulum luctus congue. Vivamus luctus consectetur sem et volutpat. Fusce finibus et nisi eget iaculis. Aenean laoreet ullamcorper odio eu ornare. Suspendisse tristique erat molestie consequat varius. Curabitur sodales in justo nec finibus. Fusce dui neque, convallis ac lorem et, accumsan viverra odio. Nullam quam mi, accumsan nec risus et, eleifend faucibus leo.

Suspendisse in sollicitudin ipsum. Vestibulum rhoncus porttitor nunc, a dignissim metus rhoncus sit amet. Etiam fermentum varius euismod. Donec at libero quis orci ullamcorper cursus. Nam euismod porta porta. Mauris laoreet accumsan fringilla. Praesent sit amet fringilla urna, in rhoncus leo. Etiam faucibus aliquet commodo.

Curabitur et auctor nisi, ut vestibulum est. Suspendisse faucibus quis nibh laoreet pharetra. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec aliquam odio pretium purus viverra suscipit. Sed nec hendrerit nisl. Pellentesque ultrices tempor nulla ut fermentum. Praesent condimentum nulla sem, eget gravida quam tempus eu. Donec dapibus orci at malesuada lobortis. Maecenas finibus nibh vitae laoreet consectetur. Nullam sed risus mattis, vulputate dui ac, dictum mauris.', end_date: '2/2/2018', funding_goal: 20000, image_url: 'https://ksr-ugc.imgix.net/assets/019/389/244/06f40117ed0635ded5bf42306497c099_original.jpeg?crop=faces&w=1024&h=576&fit=crop&v=1515435894&auto=format&q=92&s=611c1c9ec59acaa98dffff8c4fe12324', total_amount: 0)

project14 = Project.create(author: user3.username, category_id: category2.id ,user_id: user3.id, title: '100: Flower Girls Art Prints', blurb: 'A limited edition pair of silver foiled illustrations by Maya Kern', description: 'Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed hendrerit libero id pharetra viverra. Etiam fermentum venenatis dui, eget rhoncus arcu lacinia quis. Fusce tempor sagittis sollicitudin. Nullam tristique quam nisl, nec congue ex ullamcorper a. Mauris scelerisque luctus ante a placerat. Maecenas sit amet tellus at turpis gravida interdum. Nunc dapibus dui ac lorem suscipit, quis efficitur magna tempus. Vestibulum dolor velit, dictum scelerisque erat nec, molestie ornare metus. Suspendisse id dictum magna, ac vulputate odio. Nulla facilisi. In elementum vitae dui vel scelerisque. Sed et ultrices nisi. Nunc id eleifend purus. Donec sodales gravida lectus a congue. Pellentesque consectetur vestibulum purus quis varius.

Curabitur et auctor nisi, ut vestibulum est. Suspendisse faucibus quis nibh laoreet pharetra. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec aliquam odio pretium purus viverra suscipit. Sed nec hendrerit nisl. Pellentesque ultrices tempor nulla ut fermentum. Praesent condimentum nulla sem, eget gravida quam tempus eu. Donec dapibus orci at malesuada lobortis. Maecenas finibus nibh vitae laoreet consectetur. Nullam sed risus mattis, vulputate dui ac, dictum mauris.', end_date: '2/3/2018', funding_goal: 20000, image_url: 'https://ksr-ugc.imgix.net/assets/019/720/202/ee59e5fdf5601c3ca13d65ef4f353aa2_original.png?w=680&fit=max&v=1514571468&auto=format&lossless=true&s=fb4b34caaa7b82de80dda99862c33b60', total_amount: 0)



project16 = Project.create(author: user5.username, category_id: category2.id ,user_id: user5.id, title: 'Valor Anthology: Volume 2', blurb:'A comic anthology that pays homage to strength and courage', description: 'Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed hendrerit libero id pharetra viverra. Etiam fermentum venenatis dui, eget rhoncus arcu lacinia quis. Fusce tempor sagittis sollicitudin. Nullam tristique quam nisl, nec congue ex ullamcorper a. Mauris scelerisque luctus ante a placerat. Maecenas sit amet tellus at turpis gravida interdum. Nunc dapibus dui ac lorem suscipit, quis efficitur magna tempus. Vestibulum dolor velit, dictum scelerisque erat nec, molestie ornare metus. Suspendisse id dictum magna, ac vulputate odio. Nulla facilisi. In elementum vitae dui vel scelerisque. Sed et ultrices nisi. Nunc id eleifend purus. Donec sodales gravida lectus a congue. Pellentesque consectetur vestibulum purus quis varius.

Curabitur et auctor nisi, ut vestibulum est. Suspendisse faucibus quis nibh laoreet pharetra. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec aliquam odio pretium purus viverra suscipit. Sed nec hendrerit nisl. Pellentesque ultrices tempor nulla ut fermentum. Praesent condimentum nulla sem, eget gravida quam tempus eu. Donec dapibus orci at malesuada lobortis. Maecenas finibus nibh vitae laoreet consectetur. Nullam sed risus mattis, vulputate dui ac, dictum mauris.', end_date: '2/5/2018', funding_goal: 20000, image_url: 'https://ksr-ugc.imgix.net/assets/019/371/157/723a1b8c0422ea14544f970fa4956133_original.jpg?crop=faces&w=1024&h=576&fit=crop&v=1516127408&auto=format&q=92&s=41661a38a11a905b1abc978c066cdced', total_amount: 0)

project17 = Project.create(author: user1.username, category_id: category3.id ,user_id: user1.id, title: 'Concentrics: A rock balancing desk toy for mindfulness', blurb:'Bring more balance and mindfulness to your life', description: 'Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed hendrerit libero id pharetra viverra. Etiam fermentum venenatis dui, eget rhoncus arcu lacinia quis. Fusce tempor sagittis sollicitudin. Nullam tristique quam nisl, nec congue ex ullamcorper a. Mauris scelerisque luctus ante a placerat. Maecenas sit amet tellus at turpis gravida interdum. Nunc dapibus dui ac lorem suscipit, quis efficitur magna tempus. Vestibulum dolor velit, dictum scelerisque erat nec, molestie ornare metus. Suspendisse id dictum magna, ac vulputate odio. Nulla facilisi. In elementum vitae dui vel scelerisque. Sed et ultrices nisi. Nunc id eleifend purus. Donec sodales gravida lectus a congue. Pellentesque consectetur vestibulum purus quis varius.

Curabitur et auctor nisi, ut vestibulum est. Suspendisse faucibus quis nibh laoreet pharetra. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec aliquam odio pretium purus viverra suscipit. Sed nec hendrerit nisl. Pellentesque ultrices tempor nulla ut fermentum. Praesent condimentum nulla sem, eget gravida quam tempus eu. Donec dapibus orci at malesuada lobortis. Maecenas finibus nibh vitae laoreet consectetur. Nullam sed risus mattis, vulputate dui ac, dictum mauris.', end_date: '2/6/2018', funding_goal: 20000, image_url: '', total_amount: 0)

project18 = Project.create(author: user2.username, category_id: category3.id ,user_id: user2.id, title: 'Microscape | Downtown Chicago', blurb: 'Microscopes scans from the air and creates 3D renderings of the landscape', description: 'Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed hendrerit libero id pharetra viverra. Etiam fermentum venenatis dui, eget rhoncus arcu lacinia quis. Fusce tempor sagittis sollicitudin. Nullam tristique quam nisl, nec congue ex ullamcorper a. Mauris scelerisque luctus ante a placerat. Maecenas sit amet tellus at turpis gravida interdum. Nunc dapibus dui ac lorem suscipit, quis efficitur magna tempus. Vestibulum dolor velit, dictum scelerisque erat nec, molestie ornare metus. Suspendisse id dictum magna, ac vulputate odio. Nulla facilisi. In elementum vitae dui vel scelerisque. Sed et ultrices nisi. Nunc id eleifend purus. Donec sodales gravida lectus a congue. Pellentesque consectetur vestibulum purus quis varius.

Curabitur et auctor nisi, ut vestibulum est. Suspendisse faucibus quis nibh laoreet pharetra. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec aliquam odio pretium purus viverra suscipit. Sed nec hendrerit nisl. Pellentesque ultrices tempor nulla ut fermentum. Praesent condimentum nulla sem, eget gravida quam tempus eu. Donec dapibus orci at malesuada lobortis. Maecenas finibus nibh vitae laoreet consectetur. Nullam sed risus mattis, vulputate dui ac, dictum mauris.', end_date: '2/7/2018', funding_goal: 20000, image_url: 'https://ksr-ugc.imgix.net/assets/019/404/775/9578efbaea189be38a81d7eabd5bd84b_original.jpg?crop=faces&w=1024&h=576&fit=crop&v=1512674076&auto=format&q=92&s=ff6195ac476b6bf1f857035e00c36902', total_amount: 0)


reward1 = Reward.create(project_id: project1.id, title:"Your very own Signature Pokedex", description:"Includes: Full deck of Indexed Pokemon Cards, Soundtrack for Pokemon Cartoon ", amount_met:50)
reward2 = Reward.create(project_id: project3.id, title:"Stand Still Stay Silent autographed poster", description:"A poster of the full cast from 4-S signed by pulitzer prize winning graphic novel auther, Minna Sundberg", amount_met:50)
reward3 = Reward.create(project_id: project5.id, title:"Bulbasaur plushie", description:"In addition to the bonuses from the Signature Pokedex, you will also receive a Bulbasaur plushie", amount_met:100)
reward4 = Reward.create(project_id: project4.id, title:"Pokken Tournament", description:"The ulitmate Pokemon Experience. In addition to the Pokedex and Bulbasaur plushie, backers will get a copy of Pokken Tournament for the Playstation 4 where they can battle with friends online or in person to see who truly is the ultimate Pokemon trainer!", amount_met:200)
reward5 = Reward.create(project_id: project3.id, title:"Stand Still Stay Silent book 1", description:"Get caught up on the 4-S canon with an exclusive hardback copy of Book 1.  A collectors item!", amount_met:100)

joinsTable1 = ProjectCategory.create(
  project_id: project1.id,
  category_id: category1.id
)

joinsTable2 = ProjectCategory.create(
  project_id: project2.id,
  category_id: category2.id
)

