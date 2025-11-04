/*
 * Copyright (c) 2025 mqxu
 * toolkit_core is licensed under Mulan PSL v2.
 * You can use this software according to the terms and conditions of the Mulan PSL v2.
 * You may obtain a copy of Mulan PSL v2 at:
 *          http://license.coscl.org.cn/MulanPSL2
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
 * EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
 * MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
 * See the Mulan PSL v2 for more details.
 */

/**
 * 日期工具类
 * 提供日期格式化、相对时间计算、时间差计算等功能
 *
 * @author mqxu
 * @since 2025-11-01
 * @version 0.1.0
 */
export class DateUtils {
  /**
   * 日期格式化
   * 支持常用日期格式占位符
   *
   * @param {Date} date - Date 对象
   * @param {string} pattern - 格式模板
   *   - yyyy: 四位年份
   *   - MM: 两位月份 (01-12)
   *   - dd: 两位日期 (01-31)
   *   - HH: 24小时制小时 (00-23)
   *   - mm: 分钟 (00-59)
   *   - ss: 秒 (00-59)
   * @returns {string} 格式化后的日期字符串
   *
   * @example
  * ```
   * const date = new Date('2025-11-01 15:30:45');
   * DateUtils.format(date, 'yyyy-MM-dd HH:mm:ss'); // "2025-11-01 15:30:45"
   * DateUtils.format(date, 'yyyy年MM月dd日');      // "2025年11月01日"
   * ```
   */
  static format(date: Date, pattern: string = 'yyyy-MM-dd HH:mm:ss'): string {
    if (!(date instanceof Date) || isNaN(date.getTime())) {
      return '';
    }

    const year = date.getFullYear();
    const month = DateUtils.padZero(date.getMonth() + 1);
    const day = DateUtils.padZero(date.getDate());
    const hours = DateUtils.padZero(date.getHours());
    const minutes = DateUtils.padZero(date.getMinutes());
    const seconds = DateUtils.padZero(date.getSeconds());

    return pattern
      .replace(/yyyy/g, year.toString())
      .replace(/MM/g, month)
      .replace(/dd/g, day)
      .replace(/HH/g, hours)
      .replace(/mm/g, minutes)
      .replace(/ss/g, seconds);
  }

  /**
   * 将时间戳转换为 Date 对象
   *
   * @param {number} timestamp - 时间戳 (毫秒)
   * @returns {Date} Date 对象
   *
   * @example
  * ```
   * DateUtils.parseTimestamp(1730462400000); // Date对象
   * ```
   */
  static parseTimestamp(timestamp: number): Date {
    return new Date(timestamp);
  }

  /**
   * 计算相对时间 (多久之前)
   * 用于显示 "刚刚"、"3分钟前"、"2小时前"、"昨天"等
   *
   * @param {Date} date - 目标日期
   * @returns {string} 相对时间描述
   *
   * @example
  * ```
   * DateUtils.fromNow(new Date(Date.now() - 60000));      // "1分钟前"
   * DateUtils.fromNow(new Date(Date.now() - 3600000));    // "1小时前"
   * DateUtils.fromNow(new Date(Date.now() - 86400000));   // "1天前"
   * ```
   */
  static fromNow(date: Date): string {
    const now = Date.now();
    const diffMs = now - date.getTime();

    if (diffMs < 0) {
      return '未来时间';
    }

    const seconds = Math.floor(diffMs / 1000);
    const minutes = Math.floor(seconds / 60);
    const hours = Math.floor(minutes / 60);
    const days = Math.floor(hours / 24);
    const months = Math.floor(days / 30);
    const years = Math.floor(days / 365);

    if (seconds < 60) {
      return '刚刚';
    } else if (minutes < 60) {
      return `${minutes}分钟前`;
    } else if (hours < 24) {
      return `${hours}小时前`;
    } else if (days === 1) {
      return '昨天';
    } else if (days < 7) {
      return `${days}天前`;
    } else if (days < 30) {
      return `${Math.floor(days / 7)}周前`;
    } else if (months < 12) {
      return `${months}个月前`;
    } else {
      return `${years}年前`;
    }
  }

  /**
   * 计算两个日期之间的天数差
   * 用于计算连续学习天数等
   *
   * @param {Date} start - 开始日期
   * @param {Date} end - 结束日期
   * @returns {number} 天数差
   *
   * @example
  * ```
   * const start = new Date('2025-11-01');
   * const end = new Date('2025-11-10');
   * DateUtils.diffDays(start, end); // 9
   * ```
   */
  static diffDays(start: Date, end: Date): number {
    const diffMs = end.getTime() - start.getTime();
    return Math.floor(diffMs / (1000 * 60 * 60 * 24));
  }

  /**
   * 计算两个日期之间的小时差
   *
   * @param {Date} start - 开始日期
   * @param {Date} end - 结束日期
   * @returns {number} 小时差
   *
   * @example
  * ```
   * const start = new Date('2025-11-01 10:00:00');
   * const end = new Date('2025-11-01 15:30:00');
   * DateUtils.diffHours(start, end); // 5.5
   * ```
   */
  static diffHours(start: Date, end: Date): number {
    const diffMs = end.getTime() - start.getTime();
    return diffMs / (1000 * 60 * 60);
  }

  /**
   * 计算两个日期之间的分钟差
   *
   * @param {Date} start - 开始日期
   * @param {Date} end - 结束日期
   * @returns {number} 分钟差
   *
   * @example
  * ```
   * const start = new Date('2025-11-01 10:00:00');
   * const end = new Date('2025-11-01 10:30:00');
   * DateUtils.diffMinutes(start, end); // 30
   * ```
   */
  static diffMinutes(start: Date, end: Date): number {
    const diffMs = end.getTime() - start.getTime();
    return Math.floor(diffMs / (1000 * 60));
  }

  /**
   * 格式化时长 (秒 → 时:分:秒)
   * 用于显示学习时长等
   *
   * @param {number} seconds - 总秒数
   * @returns {string} 格式化后的时长字符串
   *
   * @example
  * ```
   * DateUtils.formatDuration(3661); // "01:01:01"
   * DateUtils.formatDuration(90);   // "00:01:30"
   * ```
   */
  static formatDuration(seconds: number): string {
    const hours = Math.floor(seconds / 3600);
    const minutes = Math.floor((seconds % 3600) / 60);
    const secs = seconds % 60;

    return `${DateUtils.padZero(hours)}:${DateUtils.padZero(minutes)}:${DateUtils.padZero(secs)}`;
  }

  /**
   * 格式化时长 (秒 → 人类可读格式)
   * 用于显示总学习时长等
   *
   * @param {number} seconds - 总秒数
   * @returns {string} 人类可读的时长
   *
   * @example
  * ```
   * DateUtils.formatDurationReadable(3661);  // "1小时1分钟"
   * DateUtils.formatDurationReadable(90);    // "1分钟30秒"
   * DateUtils.formatDurationReadable(36000); // "10小时"
   * ```
   */
  static formatDurationReadable(seconds: number): string {
    const hours = Math.floor(seconds / 3600);
    const minutes = Math.floor((seconds % 3600) / 60);
    const secs = seconds % 60;

    const parts: string[] = [];
    if (hours > 0) {
      parts.push(`${hours}小时`);
    }
    if (minutes > 0) {
      parts.push(`${minutes}分钟`);
    }
    if (secs > 0 && hours === 0) {
      parts.push(`${secs}秒`);
    }

    return parts.length > 0 ? parts.join('') : '0秒';
  }

  /**
   * 判断是否为今天
   *
   * @param {Date} date - 待判断的日期
   * @returns {boolean} 是否为今天
   *
   * @example
  * ```
   * DateUtils.isToday(new Date()); // true
   * ```
   */
  static isToday(date: Date): boolean {
    const today = new Date();
    return date.getFullYear() === today.getFullYear() &&
      date.getMonth() === today.getMonth() &&
      date.getDate() === today.getDate();
  }

  /**
   * 判断是否为昨天
   *
   * @param {Date} date - 待判断的日期
   * @returns {boolean} 是否为昨天
   */
  static isYesterday(date: Date): boolean {
    const yesterday = new Date(Date.now() - 86400000);
    return date.getFullYear() === yesterday.getFullYear() &&
      date.getMonth() === yesterday.getMonth() &&
      date.getDate() === yesterday.getDate();
  }

  /**
   * 获取当前周的第一天 (周一)
   *
   * @returns {Date} 本周周一的日期
   *
   * @example
  * ```
   * DateUtils.getStartOfWeek(); // 本周周一 00:00:00
   * ```
   */
  static getStartOfWeek(): Date {
    const now = new Date();
    const day = now.getDay() === 0 ? 7 : now.getDay();
    const diff = now.getDate() - day + 1;
    const monday = new Date(now.setDate(diff));
    monday.setHours(0, 0, 0, 0);
    return monday;
  }

  /**
   * 获取当前月的第一天
   *
   * @returns {Date} 本月第一天 00:00:00
   */
  static getStartOfMonth(): Date {
    const now = new Date();
    return new Date(now.getFullYear(), now.getMonth(), 1, 0, 0, 0, 0);
  }

  /**
   * 获取当前年的第一天
   *
   * @returns {Date} 本年第一天 00:00:00
   */
  static getStartOfYear(): Date {
    const now = new Date();
    return new Date(now.getFullYear(), 0, 1, 0, 0, 0, 0);
  }

  /**
   * 数字补零 (小于 10 时前面加 0)
   * @private
   */
  private static padZero(num: number): string {
    return num < 10 ? `0${num}` : num.toString();
  }
}
