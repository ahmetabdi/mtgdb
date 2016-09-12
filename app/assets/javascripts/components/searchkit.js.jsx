import * as _ from "lodash";

import {
  SearchkitManager, SearchkitProvider,
  SearchBox, RefinementListFilter, MenuFilter,
  Hits, HitsStats, NoHits, Pagination, SortingSelector,
  SelectedFilters, ResetFilters, ItemHistogramList,
  Layout, LayoutBody, LayoutResults, TopBar, 
  SideBar, ActionBar, ActionBarRow, ViewSwitcherHits, ViewSwitcherToggle, InitialLoader
} from "searchkit";

const MovieHitsGridItem = (props)=> {
  const {bemBlocks, result} = props
  let object = result._source

  let poster = "https://image.deckbrew.com/mtg/multiverseid/" + object.multiverse_id + ".jpg"
  let url = "/cards/" + object.slug
  const source:any = _.extend({}, result._source, result.highlight)
  return (
    <div className={bemBlocks.item().mix(bemBlocks.container("item"))} data-qa="hit">
      <a href={url}>
        <img data-qa="poster" className={bemBlocks.item("poster")} src={poster} />
        <div data-qa="title" className={bemBlocks.item("name")} dangerouslySetInnerHTML={{__html:source.name}}>
        </div>
      </a>
    </div>
  )
}

const MovieHitsListItem = (props)=> {
  const {bemBlocks, result} = props
  let object = result._source

  let poster = "https://image.deckbrew.com/mtg/multiverseid/" + object.multiverse_id + ".jpg"
  let url = "/cards/" + object.slug
  //let poster = "https://s3-eu-west-1.amazonaws.com/mtgdb-production/"+object.set_code+"/"+object.name+".full.jpg"

  var toSymbols = function(str) {
    if (str) {
      var all_numbers = str.match(/\d+/g)

      $(all_numbers).each(function(index, value) {
        var regex = new RegExp("\\{"+value+"\\}", "g");
        str = str.replace(regex, '<i class="mi mi-mana mi-shadow mi-'+value+'"></i>\n');
      });

      var all_characters = str.match(/[a-zA-Z]+/g)

      $(all_characters).each(function(index, value) {
        var regex = new RegExp("\\{"+value+"\\}", "g");
        str = str.replace(regex, '<i class="mi mi-'+value.toLowerCase()+' mi-mana mi-shadow"></i>\n');
      });
    }

    return str;
  }

  return (
    <div className={bemBlocks.item().mix(bemBlocks.container("item"))} data-qa="hit">
      <div className={bemBlocks.item("poster")}>
        <img data-qa="poster" src={poster}/>
      </div>
      <div className={bemBlocks.item("details")}>
        <a href={url}>
          <h3 className={bemBlocks.item("name")}>{object.name}</h3> 
        </a> <div dangerouslySetInnerHTML={{__html:toSymbols(object.mana_cost)}}></div>

        <div>
          <i className={"top-right ss ss-"+object.set_code+" ss-2x ss-"+object.rarity+""}></i> ({object.type_of_card})
        </div>
        <br />
        <div className={bemBlocks.item("text")} dangerouslySetInnerHTML={{__html:toSymbols(object.text)}}></div>
      </div>
    </div>
  )
}

const host = "https://olive-9884404.eu-west-1.bonsai.io"
const searchkit = new SearchkitManager(host, {basicAuth:"u3t4b5cc:8gunopy6frphao2s"})

var SearchKit = React.createClass({
  reloadSearch: function() {
    searchkit.reloadSearch()
  },
  render: function() {
    return (
      <SearchkitProvider searchkit={searchkit}>
        <Layout>
          <TopBar>
            <SearchBox
              autofocus={true}
              searchOnChange={true}
              placeholder="Search..."
              prefixQueryFields={["name","description"]}/>
          </TopBar>
          <LayoutBody>
            <SideBar>
              <RefinementListFilter
                id="type_of_card"
                title="Rarity"
                field="rarity"
                operator="OR"
                size={10}/>
              <RefinementListFilter
                id="color"
                title="Color"
                field="colors"
                operator="OR"
                size={10}/>
              <RefinementListFilter
                id="type"
                title="Type"
                field="types"
                operator="OR"
                size={10}/>
              <RefinementListFilter
                id="converted_mana_cost"
                title="CMC"
                field="cmc"
                operator="OR"
                size={5}/>
            </SideBar>

            <LayoutResults>
              <ActionBar>
                <ActionBarRow>
                  <HitsStats/>
                  <ViewSwitcherToggle/>
                </ActionBarRow>
                <ActionBarRow>
                  <SelectedFilters/>
                  <ResetFilters/>
                </ActionBarRow>
              </ActionBar>
              <ViewSwitcherHits
                  hitsPerPage={12}
                  hitComponents = {[
                    {key:"list", title:"List", itemComponent:MovieHitsListItem, defaultOption:true},
                    {key:"grid", title:"Grid", itemComponent:MovieHitsGridItem}
                  ]}
                  scrollTo="body"
              />
              <NoHits/>
              <InitialLoader/>
              <Pagination showNumbers={true}/>
            </LayoutResults>

          </LayoutBody>
        </Layout>
      </SearchkitProvider>
    );
  }
});

export default SearchKit
