<?php
namespace ProcessMaker\Package\DockerExecutorLua;

use Illuminate\Support\Facades\Route;
use Illuminate\Support\ServiceProvider;
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
        // Note: `processmaker4/executor-lua` is now the base image that the instance inherits from
        $image = env('SCRIPTS_LUA_IMAGE', 'processmaker4/executor-instance-lua:v1.0.0');

        \Artisan::command('docker-executor-lua:install', function () {
            // Restart the workers so they know about the new supported language
            \Artisan::call('horizon:terminate');

            // Refresh the app cache so script runners config gets updated
            \Artisan::call('optimize:clear');

            // Build the base image that `executor-instance-lua` inherits from
            system("docker build -t processmaker4/executor-lua:latest " . __DIR__ . '/..');
        });

        $config = [
            'name' => 'Lua',
            'runner' => 'LuaRunner',
            'mime_type' => 'application/x-lua',
            'image' => $image,
            'options' => ['gitRepoId' => 'sdk-node'],
            'init_dockerfile' => "FROM processmaker4/executor-lua:latest\nARG SDK_DIR\n",
        ];
        config(['script-runners.lua' => $config]);

        $this->completePluginBoot();
    }
}
