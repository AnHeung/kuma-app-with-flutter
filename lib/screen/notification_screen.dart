part of 'screen.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NotificationAppbar(),
      body: RefreshIndicator(
        onRefresh: () async =>
            BlocProvider.of<NotificationBloc>(context).add(NotificationLoad()),
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            List<NotificationItem> items = state.notificationItems;
            if (items.isNullOrEmpty) {
              return const EmptyContainer(
                title: kNotificationNoNotificationMsg,
              );
            } else if (state.status == NotificationStatus.Failure) {
              showToast(msg: state.msg);
            }else if(state.status == NotificationStatus.NetworkError){
              return RefreshContainer(
                callback: () => BlocProvider.of<NotificationBloc>(context)
                    .add(NotificationLoad()),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Stack(
                children: [
                  ListView.separated(
                    separatorBuilder: separatorBuilder(context: context, type: OrientationType.Vertical),
                    itemBuilder: (context, idx) {
                      final NotificationItem notificationItem = items[idx];
                      return NotificationItemContainer(
                        item: notificationItem,
                      );
                    },
                    itemCount: items.length,
                    scrollDirection: Axis.vertical,
                  ),
                  LoadingIndicator(isVisible: state.status == NotificationStatus.Loading,)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

