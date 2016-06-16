
#import <UIKit/UIKit.h>

typedef enum {
    LLXTopicTypeAll = 1,
    LLXTopicTypePicture = 10,
    LLXTopicTypeWord = 29,
    LLXTopicTypeVoice = 31,
    LLXTopicTypeVideo = 41
} LLXTopicType;

/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const LLXTitilesViewH;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const LLXTitilesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const LLXTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const LLXTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const LLXTopicCellBottomBarH;

/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const LLXTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
UIKIT_EXTERN CGFloat const LLXTopicCellPictureBreakH;

UIKIT_EXTERN CGFloat const LLXTopicCellTopCmtTitleH;
/** 标签-间距 */
UIKIT_EXTERN CGFloat const LLXTagMargin ;