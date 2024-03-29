part of 'genre_search_widget.dart';

class GenreSearchAppbar extends BaseAppbar {
  @override
  _GenreSearchAppbarState createState() => _GenreSearchAppbarState();
}

class _GenreSearchAppbarState extends State<GenreSearchAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      actions: [
        Container(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => showBaseDialog(
                title: kGenreFilterRemoveTitle,
                context: context,
                content: kGenreFilterRemoveMsg,
                confirmFunction: () {
                  BlocProvider.of<GenreCategoryListBloc>(context)
                      .add(GenreItemRemoveAll());
                  Navigator.pop(context);
                },
              ),
              icon: const Icon(Icons.delete_outline_rounded),
            ))
      ],
      title: const Text(kGenreSearchAppbarTitle),
    );
  }
}
