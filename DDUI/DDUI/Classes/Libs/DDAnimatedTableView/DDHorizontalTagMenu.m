//
//  DDSliderView.m
//  SomeSDK_Example
//
//  Created by mac on 09/02/2020.
//  Copyright © 2020 syedhasnain0035. All rights reserved.
//

#import "DDHorizontalTagMenu.h"

#define SCROLLVIEW_TOP_MARGIN 16.0
#define SCROLLVIEW_BOTTOM_MARGIN 16.0

@interface DDHorizontalTagMenu () {
    UIView *selectionView;
    NSInteger previousIndex;
}
@property (strong, nonatomic) UIScrollView *scrollView;
@end

@implementation DDHorizontalTagMenu
-(instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    [self initialize];
    return self;
}
-(instancetype)init {
    self = [super init];
    [self initialize];
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self initialize];
    return self;
}
-(void)initialize {
    previousIndex = -1;
    self.scrollView = [UIScrollView.alloc initWithFrame:self.bounds];
    selectionView = [UIView.alloc init];
    selectionView.tag = -1;
    [self.scrollView addSubview:selectionView];
    [self addSubview:self.scrollView];
}
-(void)layoutSubviews {
    [super layoutSubviews];
    if (self.scrollView != nil) {
        CGRect rect = self.bounds;
        rect.origin.y = SCROLLVIEW_TOP_MARGIN;
        rect.size.height = self.bounds.size.height - (SCROLLVIEW_TOP_MARGIN + SCROLLVIEW_BOTTOM_MARGIN);
        self.scrollView.frame = rect;
    }
}
-(void)setDataSource:(NSMutableArray<DDTagM *> *)dataSource {
    _dataSource = dataSource;
    [self drawViewFor:dataSource];
}
-(void)setSelectedIndex:(NSInteger)selectedIndex {
    if (previousIndex != selectedIndex) {
        _selectedIndex = selectedIndex;
        [self moveAtIndex:selectedIndex];
        previousIndex = _selectedIndex;
    }
}
-(UIView *)tagSelectionView {
    return selectionView;
}

-(void)drawViewFor:(NSArray <DDTagM *> *)tags {
    for (UIView *v in self.scrollView.subviews) {
        if (v.tag >= 0) {
            [v removeFromSuperview];
        }
    }
    self.scrollView.contentSize = CGSizeZero;
    if (tags.count == 0) {
        return;
    }
    
    CGFloat contentWidth = 0;
    for (DDTagM *tag in tags) {
        tag.height = self.frame.size.height;
        [tag calculateWidth];
        UIView *view = [self loadViewWithTag:tag withIndex:[tags indexOfObject:tag]];
        [self.scrollView addSubview:view];
        contentWidth += tag.width + tag.space;
        self.scrollView.contentSize = CGSizeMake(contentWidth, self.scrollView.frame.size.height);
    }
    [self layoutSubviews];
    if (self.scrollView.contentSize.width < self.scrollView.frame.size.width) {
        self.scrollView.contentSize = self.scrollView.frame.size;
    }
    [self.scrollView layoutSubviews];
    self.selectedIndex = self.selectedIndex;
    previousIndex = -1;
}
-(UIView *)loadViewWithTag:(DDTagM *)tag withIndex:(NSInteger)index {
    CGRect rect = CGRectMake(self.scrollView.contentSize.width + tag.space, 0, tag.width, self.scrollView.frame.size.height);
    UIView *view = [[UIView alloc]initWithFrame:rect];
    tag.frame = rect;
    rect.size.width = rect.size.width - (tag.space * 2);
    rect.origin.x = tag.space;
    UILabel *label = [UILabel.alloc initWithFrame:rect];
    tag.view = view;
    tag.label = label;
    label.text = tag.title;
    label.font = tag.font;
    [label setTextAlignment:(NSTextAlignmentCenter)];
    [view addSubview:label];
    view.tag = index;
    UITapGestureRecognizer *g = [UITapGestureRecognizer.alloc initWithTarget:self action:@selector(didTapTags:)];
    [view setUserInteractionEnabled:YES];
    [view addGestureRecognizer:g];
    view.layer.cornerRadius = tag.corner_radius;
    [view setClipsToBounds:YES];
    view.backgroundColor = UIColor.clearColor;
    [tag layoutSubView];
    return view;
}
-(void)didTapTags:(UITapGestureRecognizer *)gesture {
    NSInteger index = gesture.view.tag;
    self.selectedIndex = index;
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didTapHorizontalTagAtIndex:)]) {
        [self.delegate didTapHorizontalTagAtIndex:index];
    }
}
-(void)moveAtIndex:(NSInteger)index {
    if (self.dataSource.count <= index) {
        return;
    }
    DDTagM *tag = self.dataSource[index];
    if (tag.is_enabled) {
        [tag toggleOffSelection];
        selectionView.backgroundColor = self.selectionBackgroundColor;
        [self animateToTag:tag withAnimation:previousIndex != index];
        [self scrollToTag:tag];
    }else {
        self.selectedIndex += 1;
    }
}
-(void)animateToTag:(DDTagM *)tag withAnimation:(BOOL)isAnimated {
    DDTagM *prevTag;
    if (tag.view == nil) {
        return;
    }
    if (previousIndex != -1) {
        prevTag = self.dataSource[self->previousIndex];
    }
    if (isAnimated) {
        [UIView animateWithDuration:0.3 animations:^{
            [self selectionInitalAnimationForTag:tag andPreviousTag:prevTag];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.4 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.2 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
                [self selectionFinalAnimationForTag:tag andPreviousTag:prevTag];
            } completion:^(BOOL finished) {
                
            }];
        }];
    }else {
        [self selectionInitalAnimationForTag:tag andPreviousTag:prevTag];
        [self selectionFinalAnimationForTag:tag andPreviousTag:prevTag];
    }
}
-(void)selectionFinalAnimationForTag:(DDTagM *)tag andPreviousTag:(DDTagM *)prevTag {
    CGRect frame = tag.frame;
    CGFloat margin = 0;//6
    
    frame.size.height -= margin;
    frame.origin.y = margin/2;
    self->selectionView.frame = frame;
    self->selectionView.layer.cornerRadius = tag.corner_radius;
    selectionView.clipsToBounds = YES;
    [tag toggleOnSelection];
}

-(void)selectionInitalAnimationForTag:(DDTagM *)tag andPreviousTag:(DDTagM *)prevTag {
    self.scrollView.clipsToBounds = NO;//Do not Remove This Line For Better Selection Animation
    prevTag.is_selected = NO;
    [tag toggleOnSelection];
    [tag layoutSubView];
    [prevTag layoutSubView];
    CGRect frame = tag.frame;
    CGFloat margin = 10;//10
    frame.size.width = frame.size.width-margin;
    frame.origin.x = frame.origin.x + margin;
    frame.size.height = frame.size.height-margin;
    frame.origin.y = frame.origin.y + (margin/2);
    self->selectionView.frame = frame;
    self->selectionView.backgroundColor = self.selectionBackgroundColor;
    self->selectionView.layer.cornerRadius = tag.corner_radius;
    selectionView.clipsToBounds = YES;
}
-(void)scrollToTag:(DDTagM *)tag {
    CGRect frame = self.bounds;
    CGFloat scrollingXOffset = tag.frame.origin.x - 30;
    if (tag.frame.origin.x < tag.frame.size.width) {
        scrollingXOffset = tag.space;
    }
    CGFloat dif = self.scrollView.contentSize.width - scrollingXOffset;
    if (dif < frame.size.width) {
        dif = self.scrollView.contentSize.width - frame.size.width;
    }else {
        dif = scrollingXOffset;
    }
    [self.scrollView setContentOffset:CGPointMake(dif, 0) animated:YES];
}
-(BOOL)isMovingForward {
    return previousIndex < self.selectedIndex;
}
@end
