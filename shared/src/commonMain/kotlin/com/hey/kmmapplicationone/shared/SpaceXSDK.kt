package com.hey.kmmapplicationone.shared

import com.hey.kmmapplicationone.shared.cache.Database
import com.hey.kmmapplicationone.shared.cache.DatabaseDriverFactory
import com.hey.kmmapplicationone.shared.entity.RocketLaunch
import com.hey.kmmapplicationone.shared.network.SpaceXApi

class SpaceXSDK(databaseDriverFactory: DatabaseDriverFactory) {
    private val database = Database(databaseDriverFactory)
    private val api = SpaceXApi()

    @Throws(Exception::class) suspend fun getLaunches(forceReload: Boolean): List<RocketLaunch> {
        val cachedLaunches = database.getAllLaunches()
        return if (cachedLaunches.isNotEmpty() && !forceReload) {
            cachedLaunches
        } else {
            api.getAllLaunches().also {
                database.clearDatabase()
                database.createLaunches(it)
            }
        }
    }
}