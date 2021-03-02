import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_graphql/constants/vars.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeScreen extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
        uri: url, headers: {"Authorization": "Bearer $personalAccessToken"});

    ValueNotifier<GraphQLClient> valueNotifier = ValueNotifier<GraphQLClient>(
        GraphQLClient(
            link: httpLink,
            cache:
                OptimisticCache(dataIdFromObject: typenameDataIdFromObject)));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return GraphQLProvider(
          client: valueNotifier,
          child: MyHomePage(),
        );
      },
    );
    // return MaterialApp(
    //   title: 'Flutter GraphQL Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.indigo,
    //     visualDensity: VisualDensity.adaptivePlatformDensity,
    //   ),
    //   home: MyHomePage(),
    // );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);

  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);
  @override
  Widget build(BuildContext context) {
    //Please note that Dart uses a notation with three quotes to make the queries.

    String readRepositories = """
       query Flutter_Github_GraphQL{
            user(login: "gabriel090") {
                avatarUrl(size: 200)
                location
                name
                url
                email
                login
                 updatedAt
                 
        followers {
                  totalCount
                }
                following {
                  totalCount
                }
              }
         viewer {
          repositories(first: 10) {
            edges{
              node {
        id
        name
        description
        url
        updatedAt
        forkCount
        openGraphImageUrl
        stargazers {
          totalCount
        }
        readme: object(expression: "master:README.md") {
          ... on Blob {
            text
          }
        }
        licenseInfo {
          id
        }
        primaryLanguage {
          name
        }
        languages(first: 10) {
          nodes {
            name
          }
        }
      }
           
            }
      
    }
               
              starredRepositories(last: 12) {
                edges {
                  node {
                    id
                    name
                    nameWithOwner
                  }
                }
              }
            }
          }
      """;

    
    return Scaffold(
       backgroundColor: Color(0xfff0f0f0),
      body: Query(
        options: QueryOptions(
          document: readRepositories,
        ),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.exception != null) {
            print(result.exception);
            return Center(
                child: Text(
              result.exception.toString(),
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ));
          }

          if (result.loading) {
            return Center(child: CircularProgressIndicator());
          }

          // it can be either Map or List
          final userDetails = result.data['user'] ?? "";
          List starredRepositories =
              result.data['viewer']['repositories']['edges'];
          // List starredRepositories =
          //     result.data['viewer']['repositories']??"";
          // List myRepositories =
          //     result.data['repositories']['nodes']??"";

          return 
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 145),
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: starredRepositories.length,
                      itemBuilder: (context, index) {
                        final repository = starredRepositories[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                          ),
                          width: double.infinity,
                          height: 110,
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                             
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      repository['node']['name'] ?? "",
                                      style: TextStyle(
                                          color: primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Wrap(
                                      children: <Widget>[
                                        Icon(
                                          Icons.location_on,
                                          color: secondary,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text( repository['node']['url'] ?? "",
                                            style: TextStyle(
                                                color: primary,
                                                fontSize: 13,
                                             )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Wrap(
                                      children: <Widget>[
                                        Icon(
                                          Icons.school,
                                          color: secondary,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(repository['node']['updatedAt'] ?? "",
                                            style: TextStyle(
                                                color: primary,
                                                fontSize: 13,
                                                letterSpacing: .3)),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                          Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
          
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                            ClipOval(
                          child: Image.network(
                            userDetails["avatarUrl"],
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                            height: 50.0,
                            width: 50.0,
                          ),
                        ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            userDetails['name'] ?? "Name",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                         
                          
                        ],
                      ),
                    ),
                  ),
                       
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 120,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: TextField(
                            // controller: TextEditingController(text: locations[0]),
                            cursorColor: Theme.of(context).primaryColor,
                            style: dropdownMenuItem,
                            decoration: InputDecoration(
                                hintText: "Github Repo",
                                hintStyle: TextStyle(
                                    color: Colors.black38, fontSize: 16),
                                prefixIcon: Material(
                                  elevation: 0.0,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  child: Icon(Icons.search),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 13)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );

        },
      ),
    );
  }
}