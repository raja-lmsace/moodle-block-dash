<?php
use block_dash\local\data_source\data_source_factory;

class behat_block_dash_generator extends behat_generator_base {
    /**
     * Get a list of the entities that can be created.
     *
     * @return array entity name => information about how to generate.
     */
    protected function get_creatable_entities(): array {

        return [
            'dash blocks' => [
                'singular' => 'dash block',
                'datagenerator' => 'dash_block',
                'required' => ['type', 'name'],
                'switchids' => ['pageid' => 'pageid'],
            ],

            'dash blocks default' => [
                'singular' => 'dash block default',
                'datagenerator' => 'dash_block_default',
                'required' => ['type', 'name'],
                'switchids' => [],
            ],
        ];
    }

    protected function preprocess_dash_block(array $data): array {

        // print_r($data);exit;
        if (empty($data['type']) || !$this->is_valid_dash_type($data['type'])) {
            throw new InvalidArgumentException('Invalid or missing dash block type.');
        }

        $datasource = $this->is_valid_dash_name($data['type'], $data['name']);
        if (!$datasource || !class_exists($datasource)) {
            throw new InvalidArgumentException('Invalid dash block name.');
        }

        // $data['configdata'] = ['preferences' => ['data_source_idnumber' => $datasource]];
        $preferences['config_preferences'] = [];
        $preferences['config_data_source_idnumber'] = $datasource;

        $config = new stdClass();
        $config->data_source_idnumber = $datasource;
        $context = context_system::instance();
        $datasource = data_source_factory::build_data_source($config->data_source_idnumber, $context);
        if ($datasource) {
            if (method_exists($datasource, 'set_default_preferences')) {
                // $preferences = [];
                $datasource->set_default_preferences($preferences);
            }
        }
        $config->preferences = $preferences['config_preferences'] ?? [];

        if (isset($data['title'])) {
            $config->title = $data['title'];
        }

        $data['configdata'] = $config;
        // if (isset($data->configdata)) {
        // }
        // print_r($datasource);exit;

        return $data;
    }

    protected function preprocess_dash_block_default(array $data): array {
        $data = $this->preprocess_dash_block($data);

        return $data;
    }

    protected function is_valid_dash_type(string $type): string {
        $dashtypes = ['datasource', 'widget'];
        return in_array($type, $dashtypes);
    }

    protected function is_valid_dash_name(string $dashtype, string $name): string|false {
        $options = \block_dash\local\data_source\data_source_factory::get_data_source_form_options();
        foreach ($options as $optionname => $optionlabel) {
            if ($dashtype === 'datasource' && str_ends_with($optionname, $name . '_data_source')) {
                return $optionname;
            }
        }
        return false;
    }
}