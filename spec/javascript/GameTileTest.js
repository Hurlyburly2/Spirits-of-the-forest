import GameTile from '../../app/javascript/react/components/GameTile'

describe('GameTile', () => {
  let wrapper,
    id,
    opponent,
    onClick;
    
  beforeEach(() => {
    onClick = jasmine.createSpy('onClick spy')
    wrapper = mount(
      <GameTile
        id="1"
        opponent="Waiting for Opponent"
        handleClickTile={onClick}
      />
    )
  })
  it('should render with the correct text', () => {
    expect(wrapper.find('span').text()).toBe('Game #1Waiting for Opponent')
  })
  
  it('should render with a link', () => {
    expect(wrapper.find('a')).toBePresent();
  })
})
