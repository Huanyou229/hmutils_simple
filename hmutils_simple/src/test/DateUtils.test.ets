import { describe, expect, it } from '@ohos/hypium';
import { DateUtils } from '../main/ets/utils/DateUtils';

export default function DateUtilsTest() {
  describe('DateUtilsTest', () => {
    it('formatDate', 0, () => {
      const date = new Date('2025-11-01 15:30:45');
      const formatted = DateUtils.format(date, 'yyyy-MM-dd HH:mm:ss');
      expect(formatted).assertEqual('2025-11-01 15:30:45');
    });

    it('should_support_custom_format', 0, () => {
      const date = new Date('2025-11-01 15:30:45');
      const formatted = DateUtils.format(date, 'yyyy年MM月dd日');
      expect(formatted).assertEqual('2025年11月01日');
    });

    it('invalid_date_should_return_empty_string', 0, () => {
      const invalidDate = new Date('invalid');
      expect(DateUtils.format(invalidDate)).assertEqual('');
    });

    it('should_correctly_parse_timestamp', 0, () => {
      const timestamp = 1730462400000;
      const date = DateUtils.parseTimestamp(timestamp);
      expect(date.getTime()).assertEqual(timestamp);
    });

    it('should_correctly_display_just_now', 0, () => {
      const now = new Date();
      expect(DateUtils.fromNow(now)).assertEqual('刚刚');
    });

    it('should_correctly_display_minutes_ago', 0, () => {
      const date = new Date(Date.now() - 5 * 60 * 1000);
      expect(DateUtils.fromNow(date)).assertEqual('5分钟前');
    });

    it('should_correctly_display_hours_ago', 0, () => {
      const date = new Date(Date.now() - 2 * 60 * 60 * 1000);
      expect(DateUtils.fromNow(date)).assertEqual('2小时前');
    });

    it('should_correctly_display_days_ago', 0, () => {
      const date = new Date(Date.now() - 3 * 24 * 60 * 60 * 1000);
      expect(DateUtils.fromNow(date)).assertEqual('3天前');
    });

    it('should_correctly_calculate_day_difference', 0, () => {
      const start = new Date('2025-11-01');
      const end = new Date('2025-11-10');
      expect(DateUtils.diffDays(start, end)).assertEqual(9);
    });

    it('should_correctly_calculate_hour_difference', 0, () => {
      const start = new Date('2025-11-01 10:00:00');
      const end = new Date('2025-11-01 15:00:00');
      expect(DateUtils.diffHours(start, end)).assertEqual(5);
    });

    it('should_correctly_calculate_minute_difference', 0, () => {
      const start = new Date('2025-11-01 10:00:00');
      const end = new Date('2025-11-01 10:30:00');
      expect(DateUtils.diffMinutes(start, end)).assertEqual(30);
    });

    it('should_correctly_format_duration', 0, () => {
      expect(DateUtils.formatDuration(3661)).assertEqual('01:01:01');
      expect(DateUtils.formatDuration(90)).assertEqual('00:01:30');
      expect(DateUtils.formatDuration(3600)).assertEqual('01:00:00');
    });

    it('should_correctly_format_readable_duration', 0, () => {
      expect(DateUtils.formatDurationReadable(3661)).assertEqual('1小时1分钟');
      expect(DateUtils.formatDurationReadable(90)).assertEqual('1分钟30秒');
      expect(DateUtils.formatDurationReadable(36000)).assertEqual('10小时');
    });

    it('should_correctly_determine_if_is_today', 0, () => {
      const today = new Date();
      expect(DateUtils.isToday(today)).assertTrue();
      const yesterday = new Date(Date.now() - 24 * 60 * 60 * 1000);
      expect(DateUtils.isToday(yesterday)).assertFalse();
    });

    it('should_correctly_determine_if_is_yesterday', 0, () => {
      const yesterday = new Date(Date.now() - 24 * 60 * 60 * 1000);
      expect(DateUtils.isYesterday(yesterday)).assertTrue();
      const today = new Date();
      expect(DateUtils.isYesterday(today)).assertFalse();
    });

    it('should_return_Monday_of_current_week', 0, () => {
      const monday = DateUtils.getStartOfWeek();
      expect(monday.getDay()).assertEqual(1);
      expect(monday.getHours()).assertEqual(0);
    });

    it('should_return_first_day_of_current_month', 0, () => {
      const firstDay = DateUtils.getStartOfMonth();
      expect(firstDay.getDate()).assertEqual(1);
      expect(firstDay.getHours()).assertEqual(0);
    });

    it('should_return_first_day_of_current_year', 0, () => {
      const firstDay = DateUtils.getStartOfYear();
      expect(firstDay.getMonth()).assertEqual(0);
      expect(firstDay.getDate()).assertEqual(1);
    });
  });
}
