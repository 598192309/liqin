//
//  SDCycleScrollView.m
//  SDCycleScrollView
//



#import "SDCycleScrollView.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#define Screen_Width  [UIScreen mainScreen].bounds.size.width
#define kCycleScrollViewInitialPageControlDotSize CGSizeMake(10, 10)

NSString * const ID = @"cycleCell";

@interface SDCycleScrollView () <UICollectionViewDataSource, UICollectionViewDelegate>


@property (nonatomic, weak) UICollectionView *mainView; // 显示图片的collectionView
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *imagePathsGroup;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSInteger totalItemsCount;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIImageView *backgroundImageView; // 当imageURLs为空时的背景图

@end

@implementation SDCycleScrollView
{
    float _oldPoint;
    NSInteger _oldIndex;
    NSInteger _dragDirection;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        [self setupMainView];
        self.backgroundColor = [UIColor purpleColor];
        
    }
    return self;
}

- (void)awakeFromNib
{
    [self initialization];
    [self setupMainView];
}

- (void)initialization
{
    _autoScrollTimeInterval = 4.0;
    _titleLabelTextColor = [UIColor whiteColor];
    _titleLabelTextFont= [UIFont systemFontOfSize:14];
    _titleLabelBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _titleLabelHeight = 30;
    _autoScroll = YES;
    _infiniteLoop = YES;
    _showPageControl = NO;

    _hidesForSinglePage = YES;

    _bannerImageViewContentMode = UIViewContentModeScaleToFill;
    
    self.backgroundColor = [UIColor whiteColor];
    
    _imagePathsGroup = @[];
    
    self.pageControl = [[UIPageControl alloc] init];
    [self addSubview:self.pageControl];

}

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageNamesGroup:(NSArray *)imageNamesGroup
{
    SDCycleScrollView *cycleScrollView = [[self alloc] initWithFrame:frame];
    cycleScrollView.localizationImageNamesGroup = [NSMutableArray arrayWithArray:imageNamesGroup];
    return cycleScrollView;
}

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame shouldInfiniteLoop:(BOOL)infiniteLoop imageNamesGroup:(NSArray *)imageNamesGroup
{
    SDCycleScrollView *cycleScrollView = [[self alloc] initWithFrame:frame];
    cycleScrollView.infiniteLoop = infiniteLoop;
    cycleScrollView.localizationImageNamesGroup = [NSMutableArray arrayWithArray:imageNamesGroup];
    return cycleScrollView;
}

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageURLStringsGroup:(NSArray *)imageURLsGroup
{
    SDCycleScrollView *cycleScrollView = [[self alloc] initWithFrame:frame];
    cycleScrollView.imageURLStringsGroup = [NSMutableArray arrayWithArray:imageURLsGroup];
    return cycleScrollView;
}

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame delegate:(id<SDCycleScrollViewDelegate>)delegate placeholderImage:(UIImage *)placeholderImage
{
    SDCycleScrollView *cycleScrollView = [[self alloc] initWithFrame:frame];
    cycleScrollView.delegate = delegate;
    cycleScrollView.placeholderImage = placeholderImage;
    
    
    return cycleScrollView;
}

// 设置显示图片的collectionView
- (void)setupMainView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = self.cellSpace;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    mainView.backgroundColor = [UIColor clearColor];
    
//    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[SDCollectionViewCell class] forCellWithReuseIdentifier:ID];
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.scrollsToTop = NO;
    mainView.decelerationRate = 0;
    [self addSubview:mainView];
    _mainView = mainView;
    [_mainView addObserver:self forKeyPath:@"scrolling" options:NSKeyValueObservingOptionOld context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(NSLocalizedString(@"监听到%@对象的%@属性发生了改变， %@", nil), object, keyPath, change);
}
#pragma mark - properties

- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    _placeholderImage = placeholderImage;
    
    if (!self.backgroundImageView) {
        UIImageView *bgImageView = [UIImageView new];
        bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self insertSubview:bgImageView belowSubview:self.mainView];
        self.backgroundImageView = bgImageView;
    }
    
    self.backgroundImageView.image = placeholderImage;
}

- (void)setInfiniteLoop:(BOOL)infiniteLoop
{
    _infiniteLoop = infiniteLoop;
    
    if (self.imagePathsGroup.count) {
        self.imagePathsGroup = self.imagePathsGroup;
    }
}

-(void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
    
    [self invalidateTimer];
    
    if (_autoScroll) {
        [self setupTimer];
    }
}

- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
    
    _flowLayout.scrollDirection = scrollDirection;
}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    
    [self setAutoScroll:self.autoScroll];
}



- (void)setImagePathsGroup:(NSArray *)imagePathsGroup
{
    [self invalidateTimer];
    if (imagePathsGroup) {
        _imagePathsGroup = imagePathsGroup;

    }    
    _totalItemsCount = self.infiniteLoop ? self.imagePathsGroup.count * 100 : self.imagePathsGroup.count;
    
    if (imagePathsGroup.count != 1) {
        self.mainView.scrollEnabled = YES;
        [self setAutoScroll:self.autoScroll];
    } else {
        self.mainView.scrollEnabled = NO;
    }
    
    [self.mainView reloadData];
    
    // 总页数
    self.pageControl.numberOfPages = self.imagePathsGroup.count;

}

- (void)setImageURLStringsGroup:(NSArray *)imageURLStringsGroup
{
    _imageURLStringsGroup = imageURLStringsGroup;
    
    NSMutableArray *temp = [NSMutableArray new];
    [_imageURLStringsGroup enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * stop) {
        NSString *urlString;
        if ([obj isKindOfClass:[NSString class]]) {
            urlString = obj;
        } else if ([obj isKindOfClass:[NSURL class]]) {
            NSURL *url = (NSURL *)obj;
            urlString = [url absoluteString];
        }
        if (urlString) {
            [temp addObject:urlString];
        }
    }];
    self.imagePathsGroup = [temp copy];
    

}

- (void)setLocalizationImageNamesGroup:(NSArray *)localizationImageNamesGroup
{
    _localizationImageNamesGroup = localizationImageNamesGroup;
    self.imagePathsGroup = [localizationImageNamesGroup copy];
}

- (void)setTitlesGroup:(NSArray *)titlesGroup
{
    _titlesGroup = titlesGroup;
    if (self.onlyDisplayText) {
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < _titlesGroup.count; i++) {
            [temp addObject:@""];
        }
        self.backgroundColor = [UIColor clearColor];
        self.imageURLStringsGroup = [temp copy];
    }
}

#pragma mark - actions

- (void)setupTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)invalidateTimer
{
    [_timer invalidate];
    _timer = nil;
}



- (void)automaticScroll
{
    
    if (0 == _totalItemsCount) return;
    int currentIndex = [self currentIndex];
    int targetIndex = currentIndex + 1;
    [self scrollToIndex:targetIndex];
}

- (void)scrollToIndex:(int)targetIndex
{
    if (targetIndex >= _totalItemsCount) {
        if (self.infiniteLoop) {
            targetIndex = _totalItemsCount * 0.5;
            [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
            [_mainView setContentOffset:CGPointMake(_mainView.contentOffset.x-[self space], _mainView.contentOffset.y) animated:NO];
        }
        return;
    }
    
    [_mainView setContentOffset:CGPointMake(_mainView.contentOffset.x+self.boworrWidth+self.cellSpace, _mainView.contentOffset.y) animated:YES];
    
}

- (int)currentIndex
{
    if (_mainView.lq_width == 0 || _mainView.lq_height == 0) {
        return 0;
    }
    
    int index = 0;
    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
//        NSLog(@"%f  %f ",_mainView.contentOffset.x,_flowLayout.itemSize.width);
        index = (_mainView.contentOffset.x + _flowLayout.itemSize.width * 0.5+self.cellSpace/2-[self space]) / (_flowLayout.itemSize.width+self.cellSpace);
    } else {
        index = (_mainView.contentOffset.y + _flowLayout.itemSize.height * 0.5) / _flowLayout.itemSize.height;
    }
    
    return MAX(0, index);
}

- (int)pageControlIndexWithCurrentCellIndex:(NSInteger)index
{
    if (self.imagePathsGroup.count > 0) {
        return (int)index % self.imagePathsGroup.count;
        
    }
    return 0;}

- (void)clearCache
{
    [[self class] clearImagesCache];
}

+ (void)clearImagesCache
{
    [[[SDWebImageManager sharedManager] imageCache] clearDisk];
}

#pragma mark - life circles
- (float)space{
    return (Screen_Width - self.boworrWidth)/2;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _flowLayout.itemSize = CGSizeMake(self.boworrWidth, self.lq_height);
    
    if (_showPageControl) {
        _mainView.frame = CGRectMake(0,0, self.lq_width, self.lq_height - 20);
    }else{
        _mainView.frame = self.bounds;
    }
    CGFloat w = 20;
    self.pageControl.frame = CGRectMake(0 , 0, 200 , 20);
    self.pageControl.lq_y = _mainView.lq_bottom;
    self.pageControl.lq_centerX = self.lq_width * 0.5;
//    self.pageControl.backgroundColor = [UIColor redColor];
    self.pageControl.hidden = !self.showPageControl;
    if (_mainView.contentOffset.x == 0 &&  _totalItemsCount) {
        int targetIndex = 0;
        if (self.infiniteLoop) {
            targetIndex = _totalItemsCount * 0.5;
        }else{
            targetIndex = 0;
        }
        _oldIndex = targetIndex;
//        NSLog(@"%f",_mainView.contentOffset.x);
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
//        NSLog(@"%f",_mainView.contentOffset.x);
        [_mainView setContentOffset:CGPointMake(_mainView.contentOffset.x+[self space], _mainView.contentOffset.y) animated:NO];
//        NSLog(@"%f",_mainView.contentOffset.x);
    }

    
    if (self.backgroundImageView) {
        self.backgroundImageView.frame = self.bounds;
    }
    
}

//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self invalidateTimer];
    }
}

//解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc {
    [_mainView removeObserver:self forKeyPath:@"scrolling" ];

    _mainView.delegate = nil;
    _mainView.dataSource = nil;
}

#pragma mark - public actions

- (void)adjustWhenControllerViewWillAppera
{
    long targetIndex = [self currentIndex];
    if (targetIndex < _totalItemsCount) {
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _totalItemsCount+4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    long itemIndex = [self pageControlIndexWithCurrentCellIndex:indexPath.item];
    
    NSString *imagePath = [self.imagePathsGroup safeObjectAtIndex:itemIndex];
    
    if (!self.onlyDisplayText && [imagePath isKindOfClass:[NSString class]]) {
        if ([imagePath hasPrefix:@"http"]) {
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:self.placeholderImage];
        } else {
            UIImage *image = [UIImage imageNamed:imagePath];
            if (!image) {
                [UIImage imageWithContentsOfFile:imagePath];
            }
            cell.imageView.image = image;
        }
    } else if (!self.onlyDisplayText && [imagePath isKindOfClass:[UIImage class]]) {
        cell.imageView.image = (UIImage *)imagePath;
    }
    
    if (_titlesGroup.count && itemIndex < _titlesGroup.count) {
        cell.title = _titlesGroup[itemIndex];
    }
    
    if (!cell.hasConfigured) {
        cell.titleLabelBackgroundColor = self.titleLabelBackgroundColor;
        cell.titleLabelHeight = self.titleLabelHeight;
        cell.titleLabelTextColor = self.titleLabelTextColor;
        cell.titleLabelTextFont = self.titleLabelTextFont;
        cell.hasConfigured = YES;
        cell.imageView.contentMode = self.bannerImageViewContentMode;
        cell.clipsToBounds = YES;
        cell.onlyDisplayText = self.onlyDisplayText;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(cycleScrollView:didSelectItemAtIndex:)]) {
        [self.delegate cycleScrollView:self didSelectItemAtIndex:[self pageControlIndexWithCurrentCellIndex:indexPath.item]];
    }
    if (self.clickItemOperationBlock) {
        self.clickItemOperationBlock([self pageControlIndexWithCurrentCellIndex:indexPath.item]);
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _mainView.userInteractionEnabled = NO;
    if (!self.imagePathsGroup.count) return; // 解决清除timer时偶尔会出现的问题
    int itemIndex = [self currentIndex];
    int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:itemIndex];
    
//    if ([self.pageControl isKindOfClass:[TAPageControl class]]) {
//        TAPageControl *pageControl = (TAPageControl *)_pageControl;
//        pageControl.currentPage = indexOnPageControl;
//    } else {
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.currentPage = indexOnPageControl;
//    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _oldPoint = scrollView.contentOffset.x;
    if (self.autoScroll) {
        [self invalidateTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.autoScroll) {
        [self setupTimer];
    }
}
- (void)setCellSpace:(float)cellSpace{
    _cellSpace = cellSpace;
    UICollectionViewFlowLayout *layout = _mainView.collectionViewLayout;
    layout.minimumLineSpacing = cellSpace;
}
- (float)boworrWidth{
    if (_boworrWidth == 0) {
        _boworrWidth = Screen_Width;
    }
    return _boworrWidth;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:self.mainView];

}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    _mainView.userInteractionEnabled = YES;
    if (!self.imagePathsGroup.count) return; // 解决清除timer时偶尔会出现的问题
    int itemIndex = [self currentIndex];
    int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:itemIndex];
    
    if ([self.delegate respondsToSelector:@selector(cycleScrollView:didScrollToIndex:)]) {
        [self.delegate cycleScrollView:self didScrollToIndex:indexOnPageControl];
    } else if (self.itemDidScrollOperationBlock) {
        self.itemDidScrollOperationBlock(indexOnPageControl);
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    float currentPoint = scrollView.contentOffset.x;
    float moveWidth = currentPoint-_oldPoint;
    int shouldPage = moveWidth/(self.boworrWidth/2);
    if (velocity.x>0) {
        _dragDirection = 1;
    }else if (velocity.x<0){
        _dragDirection = -1;
    }else{
        _dragDirection = 0;
    }
    
    if (shouldPage > 0) {
        [_mainView setContentOffset:CGPointMake([self nextPointCurrentPoint:shouldPage]+_oldPoint, scrollView.contentOffset.y) animated:YES];
    }else if (shouldPage < 0){
        [_mainView setContentOffset:CGPointMake([self lastPointCurrentPoint:shouldPage]+_oldPoint, scrollView.contentOffset.y) animated:YES];
    }else{
        [_mainView setContentOffset:CGPointMake(_oldPoint, scrollView.contentOffset.y) animated:YES];
    }
}

- (void)scrollViewWillBeginDecelerating: (UIScrollView *)scrollView{
    float width = _dragDirection*[self nextPointCurrentPoint:1];
    [UIView animateWithDuration:0.2f animations:^{
        [_mainView setContentOffset:CGPointMake(width+_oldPoint, scrollView.contentOffset.y) animated:YES];
    }];

}

- (float)nextPointCurrentPoint:(int)shouldPage{
//    NSLog(@"%f",(shouldPage+1)/2*self.boworrWidth);
    return (shouldPage+1)/2*self.boworrWidth+self.cellSpace;
}
- (float)lastPointCurrentPoint:(int)shouldPage{
    shouldPage = -shouldPage;
    return -(shouldPage+1)/2*self.boworrWidth-self.cellSpace;
}


//提供给外部调用
- (void)cycleScrollViewdidScrollTobackIndex:(NSInteger)index{
    if (index == _imagePathsGroup.count - 1) {
        if (self.infiniteLoop) {
            [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
            [_mainView setContentOffset:CGPointMake(_mainView.contentOffset.x, _mainView.contentOffset.y) animated:NO];
            
            if ([self.delegate respondsToSelector:@selector(cycleScrollView:didScrollToIndex:)]) {
                [self.delegate cycleScrollView:self didScrollToIndex:5];
            }
        }
        return;
    }
    [_mainView setContentOffset:CGPointMake(_mainView.contentOffset.x-self.boworrWidth-self.cellSpace, _mainView.contentOffset.y) animated:YES];
}
- (void)cycleScrollViewdidScrollToNextIndex:(NSInteger)index{
    [self scrollToIndex:index];

}
@end



@implementation SDCollectionViewCell
{
    __weak UILabel *_titleLabel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
        [self setupTitleLabel];
    }
    
    return self;
}

- (void)dealloc{


}

- (void)setTitleLabelBackgroundColor:(UIColor *)titleLabelBackgroundColor
{
    _titleLabelBackgroundColor = titleLabelBackgroundColor;
    _titleLabel.backgroundColor = titleLabelBackgroundColor;
}

- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor
{
    _titleLabelTextColor = titleLabelTextColor;
    _titleLabel.textColor = titleLabelTextColor;
}

- (void)setTitleLabelTextFont:(UIFont *)titleLabelTextFont
{
    _titleLabelTextFont = titleLabelTextFont;
    _titleLabel.font = titleLabelTextFont;
}

- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    [self.contentView addSubview:imageView];
}

- (void)setupTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    _titleLabel.hidden = YES;
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:titleLabel];
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    _titleLabel.text = [NSString stringWithFormat:@"   %@", title];
    if (_titleLabel.hidden) {
        _titleLabel.hidden = NO;
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.onlyDisplayText) {
        _titleLabel.frame = self.bounds;
    } else {
        _imageView.frame = self.bounds;
        CGFloat titleLabelW = self.lq_width;
        CGFloat titleLabelH = _titleLabelHeight;
        CGFloat titleLabelX = 0;
        CGFloat titleLabelY = self.lq_height - titleLabelH;
        _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    }
}

@end

