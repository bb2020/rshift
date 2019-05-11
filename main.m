#import <Cocoa/Cocoa.h>
int rs_set_temp(int);

NSDictionary *getDictionary() {
  static NSDictionary *dc = nil;
  if (!dc) {
    NSData *da = [NSData dataWithContentsOfFile:@"rshift.json"];
    NSDictionary *js = [NSJSONSerialization JSONObjectWithData:da options:kNilOptions error:nil];
    if (js) { dc = [js copy]; } else { assert(0); }
    assert([dc objectForKey:@"12:00 AM"]);
  }
  return dc;
}

NSString *formatDate(NSDate *ca) {
  NSDateFormatter *ft = [[[NSDateFormatter alloc] init] autorelease];
  [ft setDateFormat:@"hh:mm a"];
  return [ft stringFromDate:ca];
}

NSUInteger getTemperature() {
  NSDictionary *dc = getDictionary();
  NSCalendar *cl = [NSCalendar currentCalendar];
  NSDate *ca = [NSDate date];

  while (1) {
    NSString *fa = formatDate(ca);
    id va = [dc objectForKey:fa];
    // NSLog(@"%@, %@, %@", ca, fa, va);
    if (va) { return [va integerValue]; }
    ca = [cl dateByAddingUnit:NSCalendarUnitMinute value:(-1) toDate:ca options:kNilOptions];
  }
}

int main() {
  [[NSTimer scheduledTimerWithTimeInterval:15 target:[NSBlockOperation blockOperationWithBlock:^{
          NSUInteger aa = getTemperature();
          assert((aa >= 1000) && (aa <= 6500));
          int rs = rs_set_temp(aa);
          // NSLog(@"%lu, %d", aa, rs);
        }] selector:@selector(main) userInfo:nil repeats:YES] fire];

  [[NSRunLoop currentRunLoop] run];
}
