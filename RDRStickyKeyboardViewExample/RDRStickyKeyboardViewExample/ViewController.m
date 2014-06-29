//
//  ViewController.m
//  RDRStickyKeyboardViewExample
//
//  Created by Damiaan Twelker on 17/01/14.
//  Copyright (c) 2014 Damiaan Twelker. All rights reserved.
//
// LICENSE
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "ViewController.h"
#import "RDRStickyKeyboardView.h"

static NSString * const CellIdentifier = @"cell";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, RDRStickyKeyboardViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) RDRStickyKeyboardView *contentWrapper;

@end

@implementation ViewController

#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    
    [self _setupSubviews];
}

#pragma mark - Private

- (void)_setupSubviews
{
    // Setup tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth
    |UIViewAutoresizingFlexibleHeight;
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:CellIdentifier];
    
    //configure the stickyKeyboardView
    UIButton * rightButton = [self newButtonWithTitle:NSLocalizedString(@"Send", nil)];
    UIButton * leftButton = [self newButtonWithTitle:NSLocalizedString(@"Other", nil)];
    
    RDRStickyKeyboardView * stickyKeyboardView = [[RDRStickyKeyboardView alloc] initWithScrollView:self.tableView delegate:self leftButton:leftButton rightButton:rightButton];
    
    stickyKeyboardView.frame = self.view.bounds;
    stickyKeyboardView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    stickyKeyboardView.textView.delegate = self;
    
    // Setup wrapper
    self.contentWrapper = stickyKeyboardView;
    
    [self.view addSubview:self.contentWrapper];
}

#pragma mark - UITableViewDelegate/UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    cell.contentView.backgroundColor = [UIColor redColor];
    
    cell.textLabel.text = @"Lorem ipsum";
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - RDRStickyKeyboardViewDelegate

-(void)didSelectLeftKeyboardButton
{
    [self onCancelTap:nil];
}
-(void)didSelectRightKeyboardButton
{
    [self onDoneTap:nil];
}

#pragma mark - Actions

-(IBAction)onDoneTap:(id)sender
{
    NSLog(@"Send tapped!!");
}

-(IBAction)onCancelTap:(id)sender
{
    NSLog(@"Other tapped!!");
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"textViewDidBeginEditing!!..");
}


- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"textViewDidEndEditing!!..");
    
}

#pragma mark - Utilities

- (UIButton *)newButtonWithTitle:(NSString *)title
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    
    [button setTitle:title
            forState:UIControlStateNormal];
    return button;
}


-(void)hideKeyboard
{
    [self.view endEditing:YES];
}

@end
