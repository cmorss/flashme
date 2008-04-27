#import "MultilineTableCell.h"

@implementation MultilineTableCell

+ (CGFloat)heightForDescription:(NSString *)aDescription {
	UIFont  *font = [UIFont systemFontOfSize:13];
	
	CGSize newSize = CGSizeMake(280.0f, 500.0f);
	
	NSLog(@"%s Description: %@", _cmd, aDescription);
	
  CGSize size = [aDescription sizeWithFont:font 
		constrainedToSize:newSize lineBreakMode:UILineBreakModeWordWrap];
																	
	return size.height + TOP_OFFSET * 2;
}

- (id)initWithFrame:(CGRect)aRect {
	
	if (self = [super initWithFrame:aRect]) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;

		descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		descriptionLabel.backgroundColor = [UIColor whiteColor];
		descriptionLabel.opaque = YES;
		descriptionLabel.textColor = [UIColor darkGrayColor];
		descriptionLabel.highlightedTextColor = [UIColor lightGrayColor];
		descriptionLabel.font = [UIFont systemFontOfSize:13];
					
		descriptionLabel.textAlignment = UITextAlignmentLeft; // default
		descriptionLabel.numberOfLines = 10;
		descriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
		[self addSubview:descriptionLabel];
		
		// CHM: why is this being done (the sample does it). We need it 
		//      later in layout subviews and setDescription
		[descriptionLabel release];		
	}
	return self;
}


- (void)setDescription:(NSString *)aDescription {
	descriptionLabel.text = aDescription;
}

- (void)setPlaceholder:(NSString *)aDescription {
//	descriptionLabel.placeholder = aDescription;
}


@end
