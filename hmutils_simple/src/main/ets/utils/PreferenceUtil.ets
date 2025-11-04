import { preferences } from '@kit.ArkData';
import { Logger } from './Logger';

export class PreferenceUtil {
  private static preferenceRecord: Map<string, PreferenceUtil> = new Map()
  private static globalContext: Context | null = null
  private dataPreferences: preferences.Preferences | null = null

  private constructor(context: Context, fileName: string) {
    try {
      preferences.removePreferencesFromCacheSync(context, fileName)
    } catch (error) {
      Logger.error(`PreferenceUtil: removePreferencesFromCacheSync error: ${JSON.stringify(error)}`)
    }
    try {
      this.dataPreferences = preferences.getPreferencesSync(context, { name: fileName })
    } catch (error) {
      Logger.error(`PreferenceUtil: getPreferencesSync error: ${JSON.stringify(error)}`)
    }
    Logger.info(`PreferenceUtil: ${fileName} init: ${this.dataPreferences != null}`)
  }

  /**
   * 初始化全局 Context（应在 EntryAbility.onCreate 中调用）
   */
  public static initGlobalContext(context: Context) {
    PreferenceUtil.globalContext = context
    Logger.info('PreferenceUtil: globalContext initialized')
  }

  /**
   * 获取 PreferenceUtil 实例
   * @param context 可选，如果未提供则使用全局 Context
   * @param fileName 文件名，默认为 'default'
   */
  public static getInstance(context?: Context, fileName: string = 'default') {
    if (PreferenceUtil.preferenceRecord.has(fileName)) {
      return PreferenceUtil.preferenceRecord.get(fileName)!!
    }

    // 优先使用传入的 context，否则使用全局 context
    let ctx = context || PreferenceUtil.globalContext

    if (!ctx) {
      throw new Error('PreferenceUtil: context is required. Call initGlobalContext() first or pass context parameter.')
    }

    let preferenceUtil: PreferenceUtil = new PreferenceUtil(ctx, fileName);
    PreferenceUtil.preferenceRecord.set(fileName, preferenceUtil)
    return preferenceUtil
  }

  public put(key: string, value: object | string) {
    if (!this.dataPreferences) {
      Logger.info(`PreferenceUtil: dataPreferences is null`)
    }
    try {
      this.dataPreferences?.putSync(key, value)
      this.dataPreferences?.flush().catch((err: Error) => {
        Logger.error(`PreferenceUtil: flush error: ${JSON.stringify(err)}`)
      })
      Logger.info(`PreferenceUtil: put: ${key} = ${JSON.stringify(value)}`)
    } catch (e) {
      Logger.info(`PreferenceUtil: put error: ${JSON.stringify(e)}`)
    }
  }

  public get(key: string, defaultValue?: object | string) {
    try {
      let data = this.dataPreferences?.getSync(key, defaultValue)
      Logger.info(`PreferenceUtil: get: ${key} = ${JSON.stringify(data)}`)
      return data
    } catch (e) {
      Logger.info(`PreferenceUtil: get error: ${JSON.stringify(e)}`)
      return defaultValue
    }
  }

  public putToArray(key: string, value: string) {
    if (!this.dataPreferences) {
      Logger.info(`PreferenceUtil: dataPreferences is null`)
    }
    let array: Array<string> = this.get(key) as Array<string> || []
    if (array.indexOf(value) !== -1) {
      return
    }
    array.push(value)
    this.put(key, array)
  }

  public removeFromArray(key: string, value: string) {
    if (!this.dataPreferences) {
      Logger.info(`PreferenceUtil: dataPreferences is null`)
    }
    let array: Array<string> = this.get(key) as Array<string> || []
    array.splice(array.indexOf(value), 1)
    this.put(key, array)
  }
}