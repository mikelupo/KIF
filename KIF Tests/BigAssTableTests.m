//
//  BigAssTableTests.m
//  KIF Tests
//
//  Created by Michael Lupo on 11/16/17.
//

#import <KIF/KIFTestCase.h>
#import <KIF/KIFUITestActor-IdentifierTests.h>
#import <KIF/KIFTestStepValidation.h>

@interface BigAssTableTests:KIFTestCase
@end

@implementation BigAssTableTests

- (void)beforeEach
{
	[tester tapViewWithAccessibilityLabel:@"Big Ass Table"];
}

-(void) afterAll
{
	[tester tapViewWithAccessibilityLabel:@"Test Suite"];
}

-(void) testToInciteNSInternalInconsistencyException
{
	//TODO: Add Manual scrolling to dequeue naturally, then search for a row that was drawn on the screen.
	UITableView *tableView = (UITableView*)[tester waitForViewWithAccessibilityLabel:@"bigAssTable"];
	for (int i=0; i<3; ++i)
	{
		[tester swipeViewWithAccessibilityLabel:tableView.accessibilityLabel inDirection:(KIFSwipeDirectionUp)];
	}

	[tester waitForAnimationsToFinish];

	//Scroll all the way to the bottom and tap the bottom-most row
	[tester waitForViewWithAccessibilityLabel:@"Cell # 300"];
	[tester tapViewWithAccessibilityLabel:@"Cell # 300"];

	//Scroll all the way to the bottom and tap the bottom-most row
	[tester waitForViewWithAccessibilityLabel:@"Cell # 250"];
	[tester tapViewWithAccessibilityLabel:@"Cell # 250"];

	NSString *tempString;
	[KIFTestActor setDefaultTimeout:1.0];
	for (int i = 249; i > 0; i--)
	{
		tempString = [NSString stringWithFormat:@"Cell # %d", i];
		[tester tapViewWithAccessibilityLabel:tempString];
	}

	[KIFTestActor setDefaultTimeout:10.0];
	//scroll to the top, and tap the top-most row
	[tester waitForViewWithAccessibilityLabel:@"Cell # 1"];
	[tester tapViewWithAccessibilityLabel:@"Cell # 1"];

	//attempt to find an element that does not exist in the table.
	[tester tryFindingViewWithAccessibilityLabel:@"Cell # 301" error:nil];
}
@end
