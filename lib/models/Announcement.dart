import 'package:flutter/material.dart';

class Announcement {
  final String id, title, postDate, relatedProject, annContent, sender;

  Announcement({
    this.id,
    this.title,
    this.postDate,
    this.relatedProject,
    this.annContent,
    this.sender,
  });
}

List<Announcement> announcements = [
  Announcement(
    id: 'A01',
    title: "Announcement 1",
    relatedProject: 'P01',
    annContent: dummyText,
    sender: 'Project Manager',
  ),
  Announcement(
    id: 'A02',
    title: "Announcement 2",
    relatedProject: 'P02',
    annContent: 'Attention Please',
    sender: 'Department Manager',
  ),
  Announcement(
    id: 'A03',
    title: "Announcement 3",
    relatedProject: 'P02',
    annContent: 'Attention Please',
    sender: 'Project Manager',
  ),
  Announcement(
    id: 'A04',
    title: "Announcement 4",
    relatedProject: 'P06',
    annContent: 'Attention Please',
    sender: 'Project Manager',
  ),
  Announcement(
    id: 'A05',
    title: "Announcement 5",
    relatedProject: 'P03',
    annContent: 'Attention Please',
    sender: 'Project Manager',
  ),
  Announcement(
    id: 'A06',
    title: "Announcement 6",
    relatedProject: 'P02',
    annContent: 'Attention Please',
    sender: 'Project Manager',
  ),
  Announcement(
    id: 'A07',
    title: "Announcement 7",
    relatedProject: 'P01',
    annContent: 'Attention Please',
    sender: 'Project Manager',
  ),
  Announcement(
    id: 'A08',
    title: "Announcement 8",
    relatedProject: 'P01',
    annContent: 'Attention Please',
    sender: 'Project Manager',
  ),
];

String dummyText =
    "Sed ultricies rhoncus sollicitudin. Sed vel velit sit amet lacus bibendum vulputate eu eu felis. Suspendisse potenti. Vivamus rhoncus dui ac turpis facilisis lacinia. Duis congue varius arcu in scelerisque. Proin commodo ex eget justo bibendum, id suscipit eros fringilla. Donec elit tortor, hendrerit varius consequat vel, aliquet mattis nunc. Etiam et augue imperdiet, tempus mauris et, pellentesque mi. Nullam nisi nisl, pretium non consectetur ut, imperdiet ut neque. Nunc vestibulum libero odio, vitae interdum risus elementum sit amet. In tempus auctor quam ac mattis. Maecenas tempor a lectus sit amet interdum. Vivamus placerat ultricies nibh nec placerat. Fusce fringilla pellentesque nisi, vitae pretium neque pretium et. Aliquam commodo gravida arcu, non venenatis lacus gravida in. "
    + "Phasellus a ipsum cursus, rhoncus metus eget, dictum augue. Vivamus quis turpis nec turpis volutpat vulputate at in nisl. In fringilla ligula sit amet dolor efficitur, eu scelerisque elit placerat. Suspendisse nunc tellus, tempus ornare mi vel, ullamcorper molestie tellus. Morbi pulvinar elit blandit sapien auctor rhoncus. Praesent elementum mauris at nibh lobortis, ac ullamcorper libero lacinia. Nunc et dapibus felis, id condimentum nisi. Mauris vel dui a tortor interdum efficitur. Proin nec tortor bibendum, ornare erat ut, placerat augue. Quisque lacinia leo odio, at bibendum ipsum porta varius. Nunc dapibus lacinia eros, quis gravida elit imperdiet ut. Nullam mattis auctor molestie. In eros turpis, euismod a ipsum ut, euismod condimentum eros. Integer iaculis facilisis lacus, at hendrerit enim cursus eu. Aliquam auctor justo id tincidunt laoreet."
    + "Duis convallis orci mattis, mollis est quis, placerat purus. Suspendisse auctor nisl vitae elementum sodales. Vestibulum vel neque nunc. Nam ut nibh ac quam venenatis sagittis. In a sem tristique, faucibus tortor nec, sodales lacus. Etiam aliquet augue id sem interdum, quis iaculis orci viverra. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Aenean quis neque et mi varius euismod eu eu odio. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Praesent efficitur risus at sodales consectetur. Nunc erat ipsum, efficitur nec varius sed, faucibus et velit. Vivamus pellentesque gravida posuere. Aliquam sapien ex, tempus vel ex sed, rhoncus sagittis turpis. Sed porta rhoncus semper."
    + "Proin tincidunt convallis vestibulum. Curabitur sit amet ante urna. Nunc pellentesque leo vel leo elementum vestibulum. Nullam efficitur bibendum dui nec mattis. Donec et elit sodales, convallis orci vel, interdum lectus. Suspendisse at leo id nisl aliquet lobortis. Nulla varius quam non nulla efficitur, nec lacinia ante posuere. Fusce fringilla lorem non fermentum aliquam. Ut venenatis laoreet nisl, quis pretium nulla efficitur nec. Nulla sed nibh nec ante euismod egestas."
    + "Suspendisse ex est, ullamcorper in metus at, laoreet convallis massa. Vivamus malesuada leo in laoreet commodo. Nullam ac commodo elit. Vestibulum fermentum viverra nulla, non mattis velit consequat sed. Vivamus ut est eget eros hendrerit fermentum. Donec massa ante, posuere id turpis eget, rutrum viverra magna. Vestibulum tempus tempus lorem sit amet laoreet. Vestibulum suscipit enim quis iaculis rhoncus. In sodales venenatis urna, in dapibus nulla auctor commodo. Sed ac diam mattis, bibendum eros ornare, maximus odio. Curabitur feugiat volutpat dolor, nec iaculis nulla vestibulum bibendum. Duis malesuada sed est sed dapibus. Fusce lorem nisi, placerat ac enim bibendum, fermentum aliquet leo. Vestibulum in blandit nunc. Etiam at diam magna. Donec sit amet tempor magna, rhoncus elementum ex.";