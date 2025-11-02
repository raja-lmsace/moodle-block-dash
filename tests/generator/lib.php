<?php
// This file is part of Moodle - http://moodle.org/
//
// Moodle is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Moodle is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Moodle.  If not, see <http://www.gnu.org/licenses/>.

/**
 * Pulse instance test instance generate defined.
 *
 * @package   mod_pulse
 * @copyright 2021, bdecent gmbh bdecent.de
 * @license   http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

// defined('MOODLE_INTERNAL') || die();

// require_once(__DIR__ . '/behat_block_dash_generator_trait.php');

// use moodle_url;
// use context_system;

require_once($CFG->dirroot . '/lib/blocklib.php');
require_once($CFG->dirroot . '/blocks/dash/lib.php');
require_once($CFG->dirroot . '/my/lib.php');


/**
 * Block dash instance generator.
 */
class block_dash_generator extends component_generator_base {

    public function create_dash_block($data, $page = null) {
        global $DB;

        $systemcontext = context_system::instance();

        $defaults = [
            'blockname' => 'dash',
            'parentcontextid' => $systemcontext->id,
            'defaultregion' => 'content',
            'defaultweight' => 0,
            'showinsubcontexts' => 1,
            'pagetypepattern' => 'my-index',
            'configdata' => '',
        ];


        $data = (object) array_merge($defaults, $data);
        // $data->configdata = '';
        $data->timecreated = time();
        $data->timemodified = $data->timecreated;
        $data->configdata = base64_encode(serialize($data->configdata));
        $data->id = $DB->insert_record('block_instances', $data);

           // Ensure the block context is created.
        context_block::instance($data->id);

        // If the new instance was created, allow it to do additional setup
        if ($block = block_instance($data->blockname, $data)) {
            $block->instance_create();
        }

        // $blockman = new \block_manager($page ?: $PAGE);
        // $block = $blockman->add_block('dash', $data['region'] ?? 'content', $data['weight'] ?? 1, true);
        // $PAGE->blocks->load_blocks();
        // $block = $PAGE->blocks->add_block_at_end_of_default_region('dash');
        // print_r($block);exit;
    }

    public function create_dash_block_default($data) {
        $page = new moodle_page();

        // $page->set_context(context_system::instance());
        // $page->set_url(new moodle_url('/my/indexsys.php'));
        // $page->set_pagetype('my-index');
        // print_r($page->regions);exit;
        $data['pagetypepattern'] = 'my-index';
        $data['parentcontextid'] = context_system::instance()->id;
        // Get current My Moodle page.
        $currentpage = my_get_page(null, MY_PAGE_PRIVATE);
        $data['subpagepattern'] = $currentpage->id;

        $this->create_dash_block($data, $page);

        my_reset_page_for_all_users(MY_PAGE_PRIVATE, 'my-index', null);

    }
}