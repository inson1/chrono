import 'package:clock_app/common/widgets/clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:timezone/timezone.dart' as timezone;

class TimezoneCardContent extends StatelessWidget {
  const TimezoneCardContent({
    Key? key,
    required this.timezoneLocation,
    required this.title,
    required this.subtitle,
    this.textColor,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Color? textColor;
  final timezone.Location timezoneLocation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // Flutter doesn't allow per character overflow, so this is a workaround
                  title,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: textColor,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
                const SizedBox(height: 4),
                TimerBuilder.periodic(
                  const Duration(seconds: 1),
                  builder: (context) {
                    return Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: textColor,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Clock(
            timezoneLocation: timezoneLocation,
            scale: 0.3,
            color: textColor,
          ),
        ],
      ),
    );
  }
}
