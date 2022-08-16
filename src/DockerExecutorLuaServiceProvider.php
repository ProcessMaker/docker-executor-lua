<?php

namespace ProcessMaker\Package\DockerExecutorLua;

use Illuminate\Support\Facades\Route;
use Illuminate\Support\ServiceProvider;
use ProcessMaker\Models\ScriptExecutor;
use ProcessMaker\Traits\PluginServiceProviderTrait;

class DockerExecutorLuaServiceProvider extends ServiceProvider
{
    use PluginServiceProviderTrait;

    const version = '1.0.0'; // Required for PluginServiceProviderTrait

    public function register()
    {
    }

    public function boot()
    {
        \Artisan::command('docker-executor-lua:install', function () {
            $scriptExecutor = ScriptExecutor::install([
                'language' => 'lua',
                'title' => 'LUA Executor',
                'description' => 'Default LUA Executor',
            ]);

            // Build the instance image. This is the same as if you were to build it from the admin UI
            \Artisan::call('processmaker:build-script-executor lua');

            // Restart the workers so they know about the new supported language
            try {
                \Artisan::call('horizon:terminate');
            } catch (\Throwable $e) {
            }
        });

        $config = [
            'name' => 'Lua',
            'runner' => 'LuaRunner',
            'mime_type' => 'application/x-lua',
            'options' => ['gitRepoId' => 'sdk-node'],
            'init_dockerfile' => [
                'ARG SDK_DIR',
                'COPY $SDK_DIR /opt/executor/sdk-lua',
                'WORKDIR /opt/executor/sdk-lua',
                'RUN luarocks make --local',
                'WORKDIR /opt/executor',
            ],
            'package_path' => __DIR__ . '/..',
            'package_version' => self::version,
        ];
        config(['script-runners.lua' => $config]);

        $this->completePluginBoot();
    }
}
